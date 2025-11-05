--        _ _   _           _
--   __ _(_) |_| |__  _   _| |__
--  / _` | | __| '_ \| | | | '_ \
-- | (_| | | |_| | | | |_| | |_) |
--  \__, |_|\__|_| |_|\__,_|_.__/
--  |___/
--
-- Manage PRs without leaving nvim

vim.pack.add {
	{ src = GH .. 'daliusd/ghlite.nvim' }
}

require('ghlite').setup({})
