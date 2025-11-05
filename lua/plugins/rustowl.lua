--                 _                _
--  _ __ _   _ ___| |_ _____      _| |
-- | '__| | | / __| __/ _ \ \ /\ / / |
-- | |  | |_| \__ \ || (_) \ V  V /| |
-- |_|   \__,_|___/\__\___/ \_/\_/ |_|
--
-- Native rust lifetimes visualisation

vim.pack.add {
	{ src = GH .. 'cordx56/rustowl' },
}

local ro = require('rustowl')
ro.setup({
	highlight_style = 'underline', -- You can also use 'undercurl
	idle_time = 200,              -- Time in milliseconds to hover with the cursor before triggering RustOwl
})

-- Configure RustOwl LSP server (disabled to avoid conflicts)
-- vim.lsp.config('rustowl', {
-- 	cmd = { 'rustowl', '--stdio' },
-- 	filetypes = { 'rust' },
-- 	root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
-- 	single_file_support = false,
-- })

-- tweak the colors
vim.api.nvim_set_hl(0, 'lifetime', { sp = '#90A959', underline = true })   -- green (lifecycle/scope)
vim.api.nvim_set_hl(0, 'imm_borrow', { sp = '#BAD7FF', underline = true }) -- blue (safe/read-only)
vim.api.nvim_set_hl(0, 'mut_borrow', { sp = '#AA749F', underline = true }) -- purple (mutable/caution)
vim.api.nvim_set_hl(0, 'move', { sp = '#88afa2', underline = true })       -- cyan (transfer/flow)
vim.api.nvim_set_hl(0, 'call', { sp = '#F4BF75', underline = true })       -- yellow (function activity)
vim.api.nvim_set_hl(0, 'outlive', { sp = '#b46958', underline = true })    -- red (constraint/warning)

-- Auto-enable RustOwl for Rust files (disabled by default to avoid conflicts)
-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = 'rust',
-- 	callback = function()
-- 		vim.lsp.enable('rustowl')
-- 	end,
-- })

-- Set up keymaps for RustOwl
vim.keymap.set(
	'n',
	'<leader>o',
	function()
		vim.cmd.Rustowl('toggle')
		print('RustOwl toggle - implement based on LSP protocol')
	end,
	{ buffer = true, desc = 'Toggle RustOwl'
	})
