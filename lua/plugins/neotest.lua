--                   _            _
--  _ __   ___  ___ | |_ ___  ___| |_
-- | '_ \ / _ \/ _ \| __/ _ \/ __| __|
-- | | | |  __/ (_) | ||  __/\__ \ |_
-- |_| |_|\___|\___/ \__\___||___/\__|
--
-- test away without leaving neovim

vim.pack.add({
	{ src = GH .. 'nvim-lua/plenary.nvim' },
	{ src = GH .. 'antoinemadec/FixCursorHold.nvim' },
	{ src = GH .. 'nvim-treesitter/nvim-treesitter' },
	{ src = GH .. 'nvim-neotest/nvim-nio' },
	{ src = GH .. 'nvim-neotest/neotest' },

	{ src = GH .. 'nvim-neotest/neotest-plenary' },
})

require("neotest").setup({
	-- projects = {
	--  ["~/Workspace/plugins/raf"] = require("neotest-plenary")({
	--    min_init = "./path/to/test_init.lua",
	--  }),
	adapters = {
		require("neotest-plenary"),
	},
})
