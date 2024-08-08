return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- See :help statusline for more information
		local filepath = "%=%m %f"
		-- Map to shorten mode names
		local modes = {
			["NORMAL"] = "N",
			["INSERT"] = "I",
			["VISUAL"] = "V",
			["V-LINE"] = "VL",
			["V-BLOCK"] = "VB",
			["REPLACE"] = "R",
			["COMMAND"] = "C",
			["EX"] = "EX",
			["MORE"] = "M",
			["CONFIRM"] = "CF",
			["TERMINAL"] = "T",
		}

		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				ignore_focus = {},
				always_divide_middle = false,
				refresh = {
					statusline = 500,
					tabline = 500,
					winbar = 0,
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return modes[str]
						end,
					},
				},
				lualine_b = { "branch" },
				lualine_c = {},
				lualine_x = { filepath },
				lualine_y = { "filetype" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { filepath },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {
				lualine_a = { "getcwd" },
				lualine_b = { "diff" },
				lualine_c = { "orgmode.statusline()" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "tabs" },
			},
			winbar = {},
			extensions = { "fugitive", "quickfix" },
		})
		-- Remove duplicate information that clutters the bottom of the screen
		-- "-- INSERT --" on the left:
		vim.opt.showmode = false
		-- "100%" linenr/col on the right:
		vim.opt.ruler = false
		-- commands on the right:
		vim.opt.showcmd = false
	end,
}
