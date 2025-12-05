--  _            _     _
-- | |_ ___  ___| |__ | |__   __ _ ___  ___
-- | __/ _ \/ __| '_ \| '_ \ / _` / __|/ _ \
-- | ||  __/ (__| | | | |_) | (_| \__ \  __/
--  \__\___|\___|_| |_|_.__/ \__,_|___/\___|
--
-- another attempt to fill the void inside

vim.pack.add {
	{ src = GH .. 'mcauley-penney/techbase.nvim' }
}

vim.cmd.colorscheme('techbase')

vim.api.nvim_set_hl(0, 'Visual', {
	fg = '#A9B7F4',
	bg = '#2B3250',
})


vim.api.nvim_set_hl(0, 'PmenuBorder', {
	fg = '#2a2f39',
	bg = 'NONE',
	-- bg = '#1c2127',
})

local groups = {
	'FloatBorder',
	'WinSeparator',
	'NormalFloat',
	'BlinkCmpMenuBorder',
	'BlinkCmpDocBorder',
	'BlinkCmpSignatureHelpBorder',
}

for _, name in pairs(groups) do
	vim.api.nvim_set_hl(0, name, { fg = '#2a2f39', bg = 'NONE' })
end
