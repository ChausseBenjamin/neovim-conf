return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "stevearc/dressing.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("fzf")
	end,
	keys = {
		-- P.aruse F.iles
		{ "<leader>pv", '<cmd>lua require("telescope.builtin").find_files()<cr>' },
		-- P.aruse B.uffers
		{ "<leader>pb", '<cmd>lua require("telescope.builtin").buffers()<cr>' },
		-- P.aruse D.iagnostics
		{ "<leader>pd", '<cmd>lua require("telescope.builtin").diagnostics()<cr>' },
		-- P.aruse with G.rep
		{ "<leader>pg", '<cmd>lua require("telescope.builtin").live_grep()<cr>' },
		-- P.roject S.earch
		{ "<leader>ps", '<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.input("Grep > ")})<cr>' },
		-- F.ind Q.uickfix
		{ "<leader>qf", '<cmd>lua require("telescope.builtin").quickfix()<cr>' },
		-- Find Git (files known to git / not ignored or untracked)
		{ "<C-p>", '<cmd>lua require("telescope.builtin").git_files()<cr>' },
		-- F.ind B.ranch
		{ "<leader>fb", '<cmd>lua require("telescope.builtin").grep_branches()<cr>' },
		-- F.ind R.eferences
		{ "<leader>fr", "<cmd>Telescope lsp_references<cr>" },
	},
	cmd = {
		"Telescope",
		"TelescopeFindFiles",
		"TelescopeFindHelp",
		"TelescopeQuickfix",
		"TelescopeGitFiles",
		"TelescopeGitCommits",
		"TelescopeGrepBranches",
	},
}
