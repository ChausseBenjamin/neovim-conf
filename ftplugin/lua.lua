--  _
-- | |_   _  __ _
-- | | | | |/ _` |
-- | | |_| | (_| |
-- |_|\__,_|\__,_|
--
-- The true Neovim config language


-- Easily test/run lua code from neovim inline

vim.keymap.set('n',
	'<leader><leader>x',
	'<cmd>update | so %<cr>',
	{ desc = 'Save and run current lua file', buffer = 0 }
)

vim.keymap.set('n',
	'<leader>x',
	'<cmd>update | .lua<cr>',
	{ desc = 'Save and run current lua line', buffer = 0 }
)

vim.keymap.set({ 'v', 'x' },
	'<leader>x',
	':lua<cr>',
	{ desc = 'Run current lua selection', buffer = 0 }
)


vim.keymap.set('n',
	'<leader>mT', '<cmd>PlenaryBustedFile %<cr>',
	{ desc = '[M]ake [T]ests' }
)
