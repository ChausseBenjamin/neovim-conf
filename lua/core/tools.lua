--  _              _
-- | |_ ___   ___ | |___
-- | __/ _ \ / _ \| / __|
-- | || (_) | (_) | \__ \
--  \__\___/ \___/|_|___/
--
-- Miscellaneous goodies

-- Prefix used by *all* plugins loaded with vim.pack
-- Ex: `vim.pack.add({ { src = GH .. 'user/repo' } })`
GH = 'git@github.com:'

-- Remove trailing white space on save
-- Except current line to avoid moving cursor
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*' },
	callback = function()
		local save_cursor = vim.fn.getpos('.')
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos('.', save_cursor)
	end,
})
