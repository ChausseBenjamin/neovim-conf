--        _ _   _
--   __ _(_) |_(_) __ _ _ __   ___  _ __ ___
--  / _` | | __| |/ _` | '_ \ / _ \| '__/ _ \
-- | (_| | | |_| | (_| | | | | (_) | | |  __/
--  \__, |_|\__|_|\__, |_| |_|\___/|_|  \___|
--  |___/         |___/
--
-- So you don't leak secrets to production

require('plugins.telescope')
vim.pack.add {
	{ src = GH .. 'antonk52/gitignore-grabber.nvim' },
}
