return {
	"echasnovski/mini.nvim",
	version = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		-- All the submodules for which the defaults are fine:
		local withDefaults = {
			"align",
			"comment",
			"jump",
			"operators",
			"splitjoin",
			"surround",
			"trailspace",
		}
		for _, pkg in ipairs(withDefaults) do
			require("mini." .. pkg).setup()
		end

		-- Safeguard while I get used to mini.surround...
		vim.keymap.set("n", "cs", function()
			vim.notify("Oops, your muscle memory tried using the Tpope surround...")
		end)

		-- Animations and delay were annoying for this one...
		local no_indent_anim = require("mini.indentscope").gen_animation.none
		require("mini.indentscope").setup({
			draw = {
				delay = 0,
				animation = no_indent_anim(),
			},
		})

		-- Custom treesitter mappings
		local gen_spec = require("mini.ai").gen_spec
		require("mini.ai").setup({
			custom_textobjects = {
				F = gen_spec.treesitter({ -- `f` is for function calls not definitions
					a = "@function.outer",
					i = "@function.inner",
				}),
				o = gen_spec.treesitter({
					a = "@loop.outer",
					i = "@loop.inner",
				}),
				c = gen_spec.treesitter({
					a = "@conditional.outer",
					i = "@conditional.inner",
				}),
				C = gen_spec.treesitter({
					a = "@class.outer",
					i = "@class.inner",
				}),
			},
		})

		-- I prefer alt for OS level commands like dmenu...
		require("mini.move").setup({
			mappings = {
				left = "<s-w>", -- west
				right = "<s-e>", -- east
				up = "<s-n>", -- north
				down = "<s-s>", -- south
				-- Disable normal mode bindings
				line_left = "",
				line_right = "",
				line_up = "",
				line_down = "",
			},
		})

		require("mini.pairs").setup({
			mappings = {
				["`"] = false,
			},
		})

		require("mini.bracketed").setup({
			-- Disable what's unnecessary or overlaps
			file = { suffix = "", options = {} },
			oldfile = { suffix = "", options = {} },
			undo = { suffix = "", options = {} },
			window = { suffix = "", options = {} },
			yank = { suffix = "", options = {} },
			treesitter = { suffix = "", options = {} },

			-- `c` already used by treesitter-textobjects
			comment = { suffix = "g", options = {} },
			quickfix = { suffix = "q", options = { wrap = false } },
		})

		local function hsl_to_rgb(h, s, l)
			s = math.max(0, math.min(1, s))
			l = math.max(0, math.min(1, l))

			local function hue_to_rgb(p, q, t)
				if t < 0 then
					t = t + 1
				end
				if t > 1 then
					t = t - 1
				end
				if t < 1 / 6 then
					return p + (q - p) * 6 * t
				end
				if t < 1 / 2 then
					return q
				end
				if t < 2 / 3 then
					return p + (q - p) * (2 / 3 - t) * 6
				end
				return p
			end

			h = (h % 360) / 360
			local q = l < 0.5 and (l * (1 + s)) or (l + s - l * s)
			local p = 2 * l - q

			local r = hue_to_rgb(p, q, h + 1 / 3)
			local g = hue_to_rgb(p, q, h)
			local b = hue_to_rgb(p, q, h - 1 / 3)

			return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
		end

		local hex_colorgroup = require("mini.hipatterns").compute_hex_color_group
		local gen_highlighter = require("mini.hipatterns").gen_highlighter
		require("mini.hipatterns").setup({
			delay = {
				text_change = 80,
				scroll = 25,
			},
			highlighters = {
				rgba = { -- Ex: rgba(103, 199, 163, 0.4)
					pattern = "rgba%(%d+,%s*%d+,%s*%d+,%s*[01]?%.?%d*%)",
					group = function(_, match)
						local r, g, b = match:match("rgba%((%d+),%s*(%d+),%s*(%d+),%s*[01]?%.?%d*%)")
						local hex = string.format("#%02x%02x%02x", r, g, b) -- Ignore alpha
						return require("mini.hipatterns").compute_hex_color_group(hex, "bg")
					end,
				},
				hexa = { -- Ex: #C0FFEE42
					pattern = "#%x%x%x%x%x%x%x%x%f[%X]",
					group = function(_, match)
						local hex = match:sub(1, 7) -- Ignore the last two alpha characters
						return require("mini.hipatterns").compute_hex_color_group(hex, "bg")
					end,
				},
				short_hex_color = { -- Ex: #bad
					pattern = "#%x%x%x%f[%X]",
					group = function(_, match)
						local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
						local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
						return hex_colorgroup(hex, "bg")
					end,
				},
				hex_color = gen_highlighter.hex_color(),
				c_hex_long = { -- Ex: 0xb7416e
					pattern = "0x%x%x%x%x%x%x%f[%X]",
					group = function(_, match)
						local hex = "#" .. match:sub(3)
						return hex_colorgroup(hex, "bg")
					end,
				},
				c_hex_short = { -- Ex: 0xfa5
					pattern = "0x%x%x%x%f[%X]",
					group = function(_, match)
						local r, g, b = match:sub(3, 3), match:sub(4, 4), match:sub(5, 5)
						local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
						return hex_colorgroup(hex, "bg")
					end,
				},
				rgb = { -- Ex: rgb(000,111,222)
					pattern = "rgb%(%d+,%s*%d+,%s*%d+%)",
					group = function(_, match)
						local r, g, b = match:match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
						local hex = string.format("#%02x%02x%02x", r, g, b)
						return hex_colorgroup(hex, "bg")
					end,
				},
				hsl = { -- Ex: hsl(180,54%,45%)
					pattern = "hsl%(%d+,%s*%d+%%,%s*%d+%%%)",
					group = function(_, match)
						local h, s, l = match:match("hsl%((%d+),%s*(%d+)%%,%s*(%d+)%%%)")
						local r, g, b = hsl_to_rgb(tonumber(h), tonumber(s) / 100, tonumber(l) / 100)
						local hex = string.format("#%02x%02x%02x", r, g, b)
						return hex_colorgroup(hex, "bg")
					end,
				},
			},
		})
	end,
}
