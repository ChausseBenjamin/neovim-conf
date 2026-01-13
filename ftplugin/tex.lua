--  _
-- | |_ _____  __
-- | __/ _ \ \/ /
-- | ||  __/>  <
--  \__\___/_/\_\
--
-- for good-looking documents


-- set build instead of make
-- pcall(vim.keymap.del('n', '<leader>mk', { buffer = 0 }))
vim.keymap.set('n',
	'<leader>mk',
	function() vim.cmd('TexlabBuild') end,
	{ buffer = 0, desc = 'Build LaTeX document' }
)

vim.keymap.set('n',
	'<leader>mq',
	vim.diagnostic.setqflist,
	{ buffer = 0, desc = 'Populate quickfix with diagnostics' }
)
