--        _
--  _   _(_)
-- | | | | |
-- | |_| | |
--  \__,_|_|
--
-- Making things pretty

vim.pack.add({
	{ src = GH .. 'stevearc/dressing.nvim' },
	{ src = GH .. 'nvim-tree/nvim-web-devicons' },
})


-- UI tweaks
require('plugins.treesitter')
require('plugins.lualine')
require('plugins.notifier')
require('plugins.themes.vague')

vim.o.winborder = 'rounded'
vim.o.pumborder = 'rounded'
