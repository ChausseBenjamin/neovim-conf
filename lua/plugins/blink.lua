--  _     _ _       _
-- | |__ | (_)_ __ | | __  ___ _ __ ___  _ __
-- | '_ \| | | '_ \| |/ / / __| '_ ` _ \| '_ \
-- | |_) | | | | | |   < | (__| | | | | | |_) |
-- |_.__/|_|_|_| |_|_|\_(_)___|_| |_| |_| .__/
--                                      |_|
-- blink and it's auto-completed

vim.pack.add {
	{
		src = GH .. 'saghen/blink.cmp',
		version = vim.version.range('1')
	},
	{ src = GH .. 'rafamadriz/friendly-snippets' },
}

local function setup_blink()
	local blink = require('blink.cmp')
	blink.setup({
		keymap = {
			preset = 'default',
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono',
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' }
		},
		signature = { enabled = true },
		snippets = { preset = 'default' }
	})
end

-- Setup blink on insert mode or when LSP attaches (faster startup)
vim.api.nvim_create_autocmd({ 'InsertEnter', 'LspAttach' }, {
	once = true,
	callback = setup_blink,
})
