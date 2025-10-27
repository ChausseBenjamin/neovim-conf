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
	-- 	yellow = '#e0a363',
	-- 	red = '#d8647e',
	blue = '#405065',
	-- 	green = '#7fa563',
	-- 	void = 'none',
}

-- Custom highlight tweaks to match codebase style
-- vim.api.nvim_set_hl(0, 'Normal', { bg = plt.void })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = plt.void })
-- vim.api.nvim_set_hl(0, 'LineNr', { fg = plt.gray })
-- vim.api.nvim_set_hl(0, 'Folded', { bg = plt.void })
vim.api.nvim_set_hl(0, 'Visual', { bg = plt.blue })
-- vim.api.nvim_set_hl(0, 'VertSplit', { bg = plt.void, fg = plt.gray })
-- vim.api.nvim_set_hl(0, 'WinSeparator', { bg = plt.void, fg = plt.gray })
-- vim.api.nvim_set_hl(0, 'StatusLine', { bg = plt.void, fg = plt.gray })
--
-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = plt.red })
-- vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = plt.blue })
-- vim.fn.matchadd('ColorColumn', '\\%82v', 100)
--
-- vim.api.nvim_set_hl(0, 'Search', { bg = plt.blue, fg = plt.yellow })
-- vim.api.nvim_set_hl(0, 'CurSearch', { bg = plt.green, fg = plt.fg })
