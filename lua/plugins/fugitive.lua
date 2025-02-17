return {
	{
		lazy = false,
		"tpope/vim-fugitive",
		dependencies = "tpope/vim-rhubarb",
		config = function() end,
		-- Only load when using one of the following commands:
		keys = {
			{ "<leader>gs", "<cmd>G<CR>", desc = "[G]it [S]tatus" },
			{ "<leader>gd", "<cmd>G difftool<CR>", desc = "[G]it [D]iff" },
			{ "<leader>gc", "<cmd>G commit<CR>", desc = "[G]it [C]ommit" },
			{ "<leader>gu", "<cmd>G push<CR>", desc = "[G]it p[u]sh" },
			{ "<leader>gp", "<cmd>G pull<CR>", desc = "[G]it [P]ull" },
			{ "<leader>gf", "<cmd>G fetch<CR>", desc = "[G]it [F]etch" },
			{ "<leader>ds", "<cmd>Gvdiffsplit!<CR>", desc = "Git [D]iff [S]plit" },
			{ "<leader>dh", "<cmd>diffget //2 | diffupdate<CR>" },
			{ "<leader>dl", "<cmd>diffget //3 | diffupdate<CR>" },
			{ "<leader>do", "<cmd>only<CR>", desc = "[D]iff [O]nly" },
			-- NOTE: dp (no leader) is already set to diffput | diffupdate by default
		},
	},
	{
		"takinoy/yadm.nvim",
		dependencies = "tpope/vim-fugitive",
		event = { "BufReadPre" },
		config = function()
			require("yadm").setup({
				yadm_dir = vim.fn.expand("$XDG_DATA_HOME/yadm/repo.git"),
			})
		end,
	},
}
