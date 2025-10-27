--                 _
--  _ __ ___   ___| | __ _ _ __   __ _  ___
-- | '_ ` _ \ / _ \ |/ _` | '_ \ / _` |/ _ \
-- | | | | | |  __/ | (_| | | | | (_| |  __/
-- |_| |_| |_|\___|_|\__,_|_| |_|\__, |\___|
--                               |___/
--
-- Warm and fuzzy autumn-like colorscheme

vim.pack.add({
	{ src = GH .. 'savq/melange-nvim' },
})

vim.cmd.colorscheme('melange')
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
