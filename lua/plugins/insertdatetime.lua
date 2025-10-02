--      _       _       _   _                    _                     _
--   __| | __ _| |_ ___| |_(_)_ __ ___   ___    (_)_ __  ___  ___ _ __| |_
--  / _` |/ _` | __/ _ \ __| | '_ ` _ \ / _ \___| | '_ \/ __|/ _ \ '__| __|
-- | (_| | (_| | ||  __/ |_| | | | | | |  __/___| | | | \__ \  __/ |  | |_
--  \__,_|\__,_|\__\___|\__|_|_| |_| |_|\___|   |_|_| |_|___/\___|_|   \__|
--
-- Save the date

vim.pack.add({
	{ src = GH .. 'AntonVanAssche/date-time-inserter.nvim' },
})

local date_time_inserter_status_ok, dti =
		pcall(require, 'date-time-inserter')
if not date_time_inserter_status_ok then
	return
end

dti.setup({
	date_format = 'YYYYMMDD',
	date_separator = '-',
	time_format = 24,
	show_seconds = false,
})

local dti_keys = {
	{
		k = '<leader>td',
		f = function() dti.insert_date() end,
		d = 'Insert [T]imestamp [D]ate',
	},
	{
		k = '<leader>tt',
		f = function() dti.insert_time() end,
		d = 'Insert [T]imestamp [T]ime',
	},
	{
		k = '<leader>tf',
		f = function() dti.insert_date_time() end,
		d = 'Insert [T]imestamp [F]ull',
	},
}

for _, map in ipairs(dti_keys) do
	vim.keymap.set('n', map.k, map.f, { desc = map.d })
end
