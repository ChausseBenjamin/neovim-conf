--  ____           _
-- |  _ \ ___  ___| |_
-- | |_) / _ \/ __| __|
-- |  __/  __/\__ \ |_
-- |_|   \___||___/\__|
--
-- PEG Grammar for Rust

vim.pack.add {
	{ src = GH .. 'pest-parser/pest.vim' },
}

require('pest-vim').setup({})
