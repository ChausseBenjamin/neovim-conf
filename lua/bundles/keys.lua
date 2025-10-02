--  _
-- | | _____ _   _ ___
-- | |/ / _ \ | | / __|
-- |   <  __/ |_| \__ \
-- |_|\_\___|\__, |___/
--           |___/
--
-- General purpose keybindings

-- Emacs pinky prevention
vim.keymap.set(
	'n',
	'<leader>w',
	'<C-w>',
	{ desc = 'Window/Split Management' }
)

-- Unmap `S`
-- Sometimes used for lsp stuff and causes issues when buffer has none
vim.keymap.set('n', 'S', '<nop>')

-- quickSave
vim.keymap.set('n', '<leader><Cr>',
	function()
		vim.cmd.update(); vim.print 'file saved'
	end, { desc = 'Save file' })

-- Easy acccess to the `:make` command
vim.keymap.set('n', '<leader>mk', function() vim.cmd.make() end,
	{ desc = 'run :make' })

-- Don't mess with pasted text
vim.keymap.set('i', '<C-r>+', '<C-r><C-o>+')

-- Capital 'Y' for system clipboard
vim.keymap.set(
	{ 'n', 'v', 'x' },
	'Y',
	'"+y',
	{ desc = 'Yank to clipboard', noremap = true }
)

-- Quick tab  and  buffer navigation
local navkeys = {
	{ '<Bslash>',   function() vim.cmd.tabnext() end,   'View next tab' },
	{ '<C-\\>',     function() vim.cmd.tabnew() end,    'Create a new tab' },
	{ '<Tab>',      function() vim.cmd.bnext() end,     'Next buffer' },
	{ '<S-Tab>',    function() vim.cmd.bprevious() end, 'Previous buffer' },
	{ '<leader>bd', function() vim.cmd.bdelete() end,   'Delete buffer' },
}
for _, map in ipairs(navkeys) do
	vim.keymap.set('n', map[1], map[2], { desc = map[3] })
end

-- Clear search highlights
vim.keymap.set('n', '<leader><leader>l', function()
	vim.cmd.nohlsearch()
end, { desc = 'Clear search highlights' })


-- Follow urls in the browser
vim.keymap.set('n', 'gU', function()
	vim.ui.open(vim.fn.expand('<cfile>'))
end, { desc = '[G]oto [U]rl' })

-- Open urls as temporary splits
local function open_url_with_lynx()
	local url

	if vim.fn.mode():match("[vV]") then
		-- Visual selection
		local _, ls, cs = unpack(vim.fn.getpos("'<"))
		local _, le, ce = unpack(vim.fn.getpos("'>"))
		local lines = vim.fn.getline(ls, le)
		if #lines == 0 then return end
		lines[#lines] = string.sub(lines[#lines], 1, ce)
		lines[1] = string.sub(lines[1], cs)
		url = table.concat(lines, ' ')
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
	else
		-- Word under cursor
		url = vim.fn.expand('<cWORD>')
	end

	if not url or url == '' then return end

	local output = vim.fn.systemlist({ 'lynx', '-dump', url })
	-- local output = vim.fn.systemlist({ 'pandoc', '-f', 'html', '-t', 'markdown',
	-- 	url })

	if vim.v.shell_error ~= 0 then return end

	vim.cmd('vsplit | enew')
	vim.bo.buftype = 'nofile'
	vim.bo.bufhidden = 'wipe'
	vim.bo.swapfile = false
	vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
end

vim.keymap.set({ 'n', 'v', 'x' }, 'gu', open_url_with_lynx,
	{ noremap = true, silent = true })
