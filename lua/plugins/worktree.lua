return {
	"ThePrimeagen/git-worktree.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	config = {
		change_directory_command = "tcd",
	},
	keys = {
		{
			"<Leader>pr",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			desc = "[P]aruse the [R]epo worktrees",
		},
		{
			"<Leader>pn",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			desc = "[P]ut a [N]ew worktree here! (idk man...)",
		},
	},
}
