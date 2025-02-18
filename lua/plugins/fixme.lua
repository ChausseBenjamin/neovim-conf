return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	cmd = {
		"TodoFzfLua",
		"TodoLocList",
		"TodoQuickFix",
		"TodoTelescope",
		"TodoTrouble",
	},
	keys = {
		{
			"<leader>tq",
			mode = "n",
			function()
				require("todo-comments.search").setqflist()
			end,
			desc = "[T]odo [Q]uickfix",
		},
		{
			"<leader>tl",
			"<cmd>Telescope todo-comments todo<cr>",
			mode = "n",
			desc = "[T]odo [L]ist (telescope)",
		},
	},
}
