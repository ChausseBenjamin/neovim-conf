--
-- __   ____ _  __ _ _   _  ___
-- \ \ / / _` |/ _` | | | |/ _ \
--  \ V / (_| | (_| | |_| |  __/
--   \_/ \__,_|\__, |\__,_|\___|
--             |___/
--
-- A cool, dark, low contrast colorscheme

vim.pack.add({
	{ src = GH .. 'vague-theme/vague.nvim' },
})

require('vague').setup({
	transparent = true,
	style = {
		boolean = 'bold',
		comments = 'italic',
		conditionals = 'none',
		functions = 'none',
		headings = 'bold',
		keywords = 'none',
		keyword_return = 'italic',
		strings = 'italic',
		variables = 'none',
		builtin_constants = 'bold',
		builtin_functions = 'none',
		builtin_types = 'bold',
		builtin_variables = 'none',
	},
	plugins = {
		cmp = {
			match = 'bold',
			match_fuzzy = 'bold',
		},
		lsp = {
			diagnostic_error = 'bold',
			diagnostic_hint = 'none',
			diagnostic_info = 'italic',
			diagnostic_ok = 'none',
			diagnostic_warn = 'bold',
		},
		telescope = {
			match = 'bold',
		},
	},
})

vim.cmd.colorscheme('vague')

local plt = {
	-- 	fg = '#cdcdcd',
	-- 	bg = '#141415',
	-- 	gray = '#606079',
	blue   = '#405065',
	green  = '#80a766',
	yellow = '#f1bf81',
	red    = '#d56380',
	-- 	void = 'none',
}

-- Custom highlight tweaks to match codebase style
vim.api.nvim_set_hl(0, 'Visual', { bg = plt.blue })
vim.api.nvim_set_hl(0, 'lualine_b_diff_added', { bg = plt.green })
vim.api.nvim_set_hl(0, 'lualine_b_diff_modified', { bg = plt.yellow })
vim.api.nvim_set_hl(0, 'lualine_b_diff_removed', { bg = plt.red })
