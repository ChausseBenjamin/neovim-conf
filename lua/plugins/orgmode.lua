return {
	"nvim-orgmode/orgmode",
	dependencies = {
		{ -- Nicely formatted bullet Headings
			"akinsho/org-bullets.nvim",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				local bullets = require("org-bullets")
				bullets.setup({
					symbols = {
						-- list items
						list = "",
						checkboxes = {
							done = { "", "OrgDone" }, -- or 
							todo = { "", "OrgTodo" }, -- or 
							half = { "", "OrgHalf" }, -- or 
						},
					},
				})
			end,
		},
		{ -- Format tables easily
			"dhruvasagar/vim-table-mode",
		},
	},
	event = { "BufEnter", "BufNewFile" },
	ft = { "org" },
	config = function()
		-- This is bound to org-modern:
		-- local Menu = require("org-modern.menu")
		-- Setup orgmode
		require("orgmode").setup({
			-- win_split_mode = {'float', 0.9},
			-- win_split_mode = 'float',
			org_agenda_files = "~/Dropbox/org/**/*",
			org_default_notes_file = "~/Dropbox/org/index.org",
			calendar_week_start_day = 0,
			org_tags_column = 80,
			emacs_config = {
				-- executable_path = '/opt/homebrew/bin/emacs',
				config_path = "$HOME/.config/emacs/early-init.el",
			},
		})
		vim.opt.conceallevel = 2
		vim.opt.concealcursor = "v"

		-- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
		-- add `org` to ignore_install
		-- require('nvim-treesitter.configs').setup({
		--   ensure_installed = 'all',
		--   ignore_install = { 'org' },
		-- })
	end,
}
