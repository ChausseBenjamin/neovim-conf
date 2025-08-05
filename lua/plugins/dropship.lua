--      _                     _     _
--   __| |_ __ ___  _ __  ___| |__ (_)_ __
--  / _` | '__/ _ \| '_ \/ __| '_ \| | '_ \
-- | (_| | | | (_) | |_) \__ \ | | | | |_) |
--  \__,_|_|  \___/| .__/|___/_| |_|_| .__/
--                 |_|               |_|
--
-- Get dropped right back into you projects

vim.pack.add({
	{ src = GH .. "nvim-lua/plenary.nvim" },
	{
		src = GH .. "nvim-telescope/telescope.nvim",
		version = vim.version.range('0.1')
	},
	{ src = GH .. "ChausseBenjamin/dropship.nvim" }
})

require('telescope').setup()

local ds = require('dropship')
ds.setup({
	new_tab_explorer = false, -- Set to true to use `:Exp` on new tabs
	drop_locations = "~/.cache/shortcuts.lua",
})

local ds_keys = {
	{
		k = "<leader>dt",
		f = function() ds.new_tab() end,
		d = "[D]ropship in a new [T]ab"
	},
	{
		k = "<leader>dc",
		f = function() ds.current_tab() end,
		d = "[D]ropship [C]urrent tab",
	},
	{
		k ="<leader>de",
		f = function() ds.globally() end,
		d = "[D]ropship [E]verywhere",
	},
}

for _, map in ipairs(ds_keys) do
	vim.keymap.set("n", map.k, map.f, { desc = map.d })
end
