--  _
-- | |_   _  __ _
-- | | | | |/ _` |
-- | | |_| | (_| |
-- |_|\__,_|\__,_|
--
-- The true Neovim config language

require('plugins.neotest')

local keys = {
	{
		d = 'Save and run current lua file',
		k = '<leader><leader>x',
		cmd = '<cmd>update | so %<cr>',
		m = 'n',
	},
	{
		d = 'Save and run current lua line',
		k = '<leader>x',
		cmd = '<cmd>update | .lua<cr>',
		m = 'n',
	},
	{
		d = 'Run current lua selection',
		k = '<leader>x',
		cmd = ':lua<cr>',
		m = { 'v', 'x' },
	},
}

for _, map in ipairs(keys) do
	vim.keymap.set(map.m, map.k, map.cmd, { desc = map.d, buffer = 0 })
end
