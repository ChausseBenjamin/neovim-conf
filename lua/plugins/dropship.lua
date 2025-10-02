--      _                     _     _
--   __| |_ __ ___  _ __  ___| |__ (_)_ __
--  / _` | '__/ _ \| '_ \/ __| '_ \| | '_ \
-- | (_| | | | (_) | |_) \__ \ | | | | |_) |
--  \__,_|_|  \___/| .__/|___/_| |_|_| .__/
--                 |_|               |_|
--
-- Get dropped right back into you projects

vim.pack.add({
	{ src = GH .. 'nvim-lua/plenary.nvim' },
	{
		src = GH .. 'nvim-telescope/telescope.nvim',
		version = vim.version.range('0.1')
	},
})
DevAdd('ChausseBenjamin/dropship.nvim')

local ts = require('telescope')
ts.setup({
	extensions = {
		dropship = {
			new_tab_explorer = false,
			drop_locations = '~/.cache/shortcuts.lua',
		}
	}
})

ts.load_extension('dropship')

local function lazy_ds(method)
	return function()
		require('telescope').extensions.dropship[method]()
	end
end

local ds_keys = {
	{
		k = '<leader>dt',
		f = lazy_ds('new_tab'),
		d = '[D]ropship in a new [T]ab'
	},
	{
		k = '<leader>dc',
		f = lazy_ds('current_tab'),
		d = '[D]ropship [C]urrent tab',
	},
	{
		k = '<leader>de',
		f = lazy_ds('globally'),
		d = '[D]ropship [E]verywhere',
	},
}

for _, map in ipairs(ds_keys) do
	vim.keymap.set('n', map.k, map.f, { desc = map.d })
end
