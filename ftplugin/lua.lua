--  _
-- | |_   _  __ _
-- | | | | |/ _` |
-- | | |_| | (_| |
-- |_|\__,_|\__,_|
--
-- The true Neovim config language

require('plugins.neotest')
local neotest = require('neotest')

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
	{
		d = 'Run the nearest test',
		k = '<leader>mt',
		cmd = neotest.run.run,
		m = 'n',
	},
	{
		d = 'Stop the nearest test',
		k = '<leader>ms',
		cmd = neotest.run.stop,
		m = 'n',
	},
	{
		d = 'Attach to the nearest test',
		k = '<leader>ma',
		cmd = neotest.run.attach,
		m = 'n',
	},
	{
		d = 'Watch the nearest test',
		k = '<leader>mw',
		cmd = neotest.watch.watch,
		m = 'n',
	},
	{
		d = 'Run all tests in file',
		k = '<leader>mT',
		cmd = function() neotest.run.run(vim.fn.expand('%')) end,
		m = 'n',
	},
	{
		d = 'Stop all tests in file',
		k = '<leader>mS',
		cmd = function() neotest.run.stop(vim.fn.expand('%')) end,
		m = 'n',
	},
	{
		d = 'Attach to all tests in file',
		k = '<leader>mA',
		cmd = function() neotest.run.attach(vim.fn.expand('%')) end,
		m = 'n',
	},
	{
		d = 'Watch all tests in file',
		k = '<leader>mW',
		cmd = function() neotest.watch.watch(vim.fn.expand('%')) end,
		m = 'n',
	},
}

for _, map in ipairs(keys) do
	vim.keymap.set(map.m, map.k, map.cmd, { desc = map.d, buffer = 0 })
end
