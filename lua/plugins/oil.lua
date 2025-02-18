return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			columns = { "icon" },
			keymaps = {
				["<C-h>"] = false,
				["<M-h>"] = "actions.select_split",
			},
			view_options = {
				show_hidden = true,
			},
		})
	end,
	keys = {

		{ -- Open parent directory
			"-",
			"<cmd>Oil<CR>",
			mode = "n",
			desc = "Open parent directory",
		},
	},
}
