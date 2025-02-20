return {
	{ -- Best Git integration
		lazy = false,
		"tpope/vim-fugitive",
		dependencies = "tpope/vim-rhubarb",
		config = function() end,
		-- Only load when using one of the following commands:
		keys = {
			-- commands that accept ranges
			{
				"<leader>gh",
				function()
					if vim.fn.mode():match("[vV]") then
						local start_line = vim.fn.line("'<")
						local end_line = vim.fn.line("'>")
						vim.cmd(start_line .. "," .. end_line .. "Gclog")
					else
						vim.cmd.Gclog()
					end
				end,
				desc = "[G]it [H]istory",
				mode = { "n", "v", "x" },
			},
			{
				"<leader>gb",
				function()
					if vim.fn.mode():match("[vV]") then
						local start_line = vim.fn.line("'<")
						local end_line = vim.fn.line("'>")
						vim.cmd(start_line .. "," .. end_line .. "G blame")
					else
						vim.cmd.Gclog()
					end
				end,
				desc = "[G]it [B]lame",
				mode = { "n", "v", "x" },
			},
			-- non range commands
			{ "<leader>gs", vim.cmd.Git, desc = "[G]it [S]tatus" },
			{
				"<leader>gd",
				function()
					vim.cmd.Git("difftool")
				end,
				desc = "[G]it [D]iff",
			},
			{
				"<leader>gc",
				function()
					vim.cmd.Git("commit")
				end,
				desc = "[G]it [C]ommit",
			},
			{
				"<leader>gu",
				function()
					vim.cmd.Git("push")
				end,
				desc = "[G]it p[u]sh",
			},
			{
				"<leader>gp",
				function()
					vim.cmd.Git("pull")
				end,
				desc = "[G]it [P]ull",
			},
			{
				"<leader>gf",
				function()
					vim.cmd.Git("fetch")
				end,
				desc = "[G]it [F]etch",
			},
			{ "<leader>ds", "<cmd>Gvdiffsplit!<cr>", desc = "Git [D]iff [S]plit" },
			{ "<leader>dh", "<cmd>diffget //2 | diffupdate<cr>", desc = "[D]iff select left" },
			{ "<leader>dl", "<cmd>diffget //3 | diffupdate<cr>", desc = "[D]iff select right" },
			{ "<leader>do", vim.cmd.only, desc = "[D]iff [O]nly" },
			-- NOTE: dp (no leader) is already set to diffput | diffupdate by default
		},
	},
	{
		"antonk52/gitignore-grabber.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		cmd = "Gitignore",
	},
	{ -- To quickly view what has/hasn't been added/committed
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		-- Only enable if git is installed
		cond = function()
			return vim.fn.executable("git") == 1
		end,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local gs = require("gitsigns")
			gs.setup()
			local ts_repeat = require("nvim-treesitter.textobjects.repeatable_move")
			local function navopts()
				return {
					wrap = true,
					foldopen = true,
					navigation_message = true,
					preview = false,
					count = vim.v.count1,
				}
			end
			local next_hunk, prev_hunk = ts_repeat.make_repeatable_move_pair( --
				function()
					gs.nav_hunk("next", navopts())
				end,
				function()
					gs.nav_hunk("prev", navopts())
				end
			)
			vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk, { desc = "next [H]unk" })
			vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk, { desc = "prev [H]unk" })
		end,
	},
	{ -- Because I use yadm for dotfiles
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
