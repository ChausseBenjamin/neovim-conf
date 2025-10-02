-- Run test under the cursor
vim.keymap.set('n', '<leader>mt', function() vim.cmd('RustTest') end,
	{ desc = 'Run test under cursor' })

-- Run all tests in the file
vim.keymap.set('n', '<leader>mT', function() vim.cmd('RustTest!') end,
	{ desc = 'Run all tests' })
