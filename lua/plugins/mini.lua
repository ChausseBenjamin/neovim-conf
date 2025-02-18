return {
	"echasnovski/mini.nvim",
	version = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		config = function()
			-- All the submodules for which the defaults are fine:
			local withDefaults = {
				"bracketed",
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
					L = gen_spec.treesitter({
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
		end,
	},
}
