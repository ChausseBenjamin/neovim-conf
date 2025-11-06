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

-- Utility for my plugin development workflow
function DevAdd(repo)
	local name = repo:match('.+/(.+)$')
	local local_path = vim.fn.expand('~/Workspace/plugins/' .. name)

	if vim.fn.isdirectory(local_path) == 1 then
		vim.opt.runtimepath:prepend(local_path)
	else
		vim.pack.add({ { src = GH .. repo } })
	end
end

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

-- Free a mapping (save and delete it, like dd)
-- Returns the saved mapping info for later restoration
function FreeMapping(key, mode, buffer)
	mode = mode or 'n'
	buffer = buffer or 0

	local saved = vim.fn.maparg(key, mode, false, true)

	if saved and saved.lhs and saved.lhs ~= '' then
		pcall(function()
			if buffer == 0 then
				vim.keymap.del(mode, key)
			else
				vim.keymap.del(mode, key, { buffer = buffer })
			end
		end)
	end

	return saved
end

-- Restore a mapping from saved mapping info
function RestoreMapping(saved)
	if not saved or not saved.lhs then
		return
	end

	local opts = {
		silent = saved.silent == 1,
		noremap = saved.noremap == 1,
		expr = saved.expr == 1,
		nowait = saved.nowait == 1,
	}

	if saved.buffer ~= 0 then
		opts.buffer = saved.buffer
	end

	vim.keymap.set(saved.mode, saved.lhs, saved.rhs, opts)
end

-- Follow urls in the browser
vim.keymap.set('n', 'gu', function()
	vim.ui.open(vim.fn.expand('<cfile>'))
end, { desc = '[G]oto [U]rl' })
