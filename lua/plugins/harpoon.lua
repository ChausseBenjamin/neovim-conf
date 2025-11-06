--  _
-- | |__   __ _ _ __ _ __   ___   ___  _ __
-- | '_ \ / _` | '__| '_ \ / _ \ / _ \| '_ \
-- | | | | (_| | |  | |_) | (_) | (_) | | | |
-- |_| |_|\__,_|_|  | .__/ \___/ \___/|_| |_|
--                  |_|
--
-- Hook onto files and never let go

require('plugins.telescope')
vim.pack.add {
	{
		src = GH .. 'theprimeagen/harpoon',
		version = 'harpoon2'
	},
	{
		src = GH .. 'mike-jl/harpoonEx',
		opts = { reload_on_dir_change = true }
	}
}

local hp = require('harpoon')
hp:setup({}) -- Setup FIRST

local hpx = require('harpoonEx')
hp:extend(hpx.extend()) -- Then extend

local hp_keys = {
	{
		d = 'Add [H]arpoon',
		k = '<leader>h',
		f = function()
			hp:list():add()
			local filename = vim.fn.expand('%:t')
			vim.print('Harpoon added: ' .. (filename ~= '' and filename or '[No Name]'))
		end,
	},
	{
		d = 'Edit Harpoons',
		k = '<C-e>',
		f = function()
			hp.ui:toggle_quick_menu(hp:list())
		end,
	},
	{
		d = 'Select Harpoon 1',
		k = '<C-h>',
		f = function()
			hp:list():select(1)
		end,
	},
	{
		d = 'Select Harpoon 2',
		k = '<C-j>',
		f = function()
			hp:list():select(2)
		end,
	},
	{
		d = 'Select Harpoon 3',
		k = '<C-k>',
		f = function()
			hp:list():select(3)
		end,
	},
	{
		d = 'Select Harpoon 4',
		k = '<C-l>',
		f = function()
			hp:list():select(4)
		end,
	},
	{
		d = 'Select Harpoon 5',
		k = '<C-;>',
		f = function()
			hp:list():select(5)
		end,
	},
	{
		d = 'Select Previous Harpoon',
		k = '<C-S-P>',
		f = function()
			hp:list():prev()
		end,
	},
	{
		d = 'Select [N]ext Harpoon',
		k = '<C-S-N>',
		f = function()
			hp:list():next()
		end,
	},
}

for _, map in ipairs(hp_keys) do
	vim.keymap.set('n', map.k, map.f, { desc = map.d })
end
