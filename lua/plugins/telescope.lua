return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = true,
		keys = {
			{
				"<leader>pv",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "[P]aruse [F]iles",
			},
			{
				"<leader>pb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "[P]aruse [B]uffers",
			},
			{
				"<leader>pd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "[P]aruse [D]iagnostics",
			},
			{
				"<leader>pg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "[P]aruse with [G]rep",
			},
			{
				"<leader>ps",
				function()
					vim.ui.input({ prompt = "Grep > " }, function(input)
						require("telescope.builtin").grep_string({ input })
					end)
				end,
				desc = "[P]roject [S]earch",
			},
			{
				"<leader>fq",
				function()
					require("telescope.builtin").quickfix()
				end,
				desc = "[F]ind [Q]uickfix",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "[F]ind [R]eferences",
			},
			{
				"<C-p>",
				function()
					if Is_git_repo() then
						require("telescope.builtin").git_files()
					else
						require("telescope.builtin").find_files()
					end
				end,
				desc = "[P]aruse Git Files",
			},
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
	},
	{
		"LukasPietzschmann/telescope-tabs",
		config = function()
			require("telescope").load_extension("telescope-tabs")
			require("telescope-tabs").setup()
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			-- P.aruse T.abs
			{
				"<leader>pt",
				function()
					require("telescope-tabs").list_tabs()
				end,
			},
		},
	},
}
