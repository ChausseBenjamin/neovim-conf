return {
	"ChausseBenjamin/dropship.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	opts = {
		new_tab_explorer = false, -- Set to true to use `:Exp` on new tabs
		drop_locations = "~/.cache/nvim-dropsites.lua",
	},
	keys = {
		{
			"<leader>dt",
			function() -- creates a new tab, then uses `:tcd`
				require("dropship").new_tab()
			end,
			mode = "n",
			desc = "[D]ropship in a new [T]ab",
		},
		{
			"<leader>dc",
			function() -- uses `:tcd` on current tab
				require("dropship").current_tab()
			end,
			mode = "n",
			desc = "[D]ropship [C]urrent tab",
		},
		{
			"<leader>dg",
			function() -- uses `:cd`
				require("dropship").globally()
			end,
			mode = "n",
			desc = "[D]ropship [G]lobally",
		},
	},
	cmd = {
		"DropshipCurrentTab",
		"DropshipNewTab",
		"DropshipGlobalDir",
	},
}
