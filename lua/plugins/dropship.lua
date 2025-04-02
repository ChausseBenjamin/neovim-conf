return {
	"ChausseBenjamin/dropship.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	opts = {
		new_tab_explorer = false, -- Set to true to use `:Exp` on new tabs
		drop_locations = "~/.cache/nvim_dropsites.lua",
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
			"<leader>dh",
			function() -- uses `:tcd` on current tab
				require("dropship").current_tab()
			end,
			mode = "n",
			desc = "[D]ropship right [H]ere",
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
