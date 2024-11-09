return {
	"ThePrimeagen/git-worktree.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	config = true,
	keys = {
		{ "<Leader>pw", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>" },
		{ "<Leader>pn", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>" },
	},
}
