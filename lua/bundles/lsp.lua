--  _
-- | |___ _ __
-- | / __| '_ \
-- | \__ \ |_) |
-- |_|___/ .__/
--       |_|
--
-- Custom tweaks to pre-made lsp configurations

vim.pack.add {
	{ src = GH .. 'neovim/nvim-lspconfig' },
}

vim.lsp.enable({
	"gopls",
	"golangci_lint_ls",
	"lua_ls",
	"bashls",
	"ruff",
	"texlab",
	"rust_analyzer",
	"zls",
	"graphql"
})

-- Load more stuff now that the lsp is installed
require('plugins.blink')

-- tweaks to mute lua errors in the Neovim config:
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

local lsp_keys = {
	{
		k = "<leader>r",
		f = vim.lsp.buf.rename,
		d = "Rename object across all occurences"
	},
	{
		k = "<leader>fa",
		f = vim.lsp.buf.code_action,
		d = "Run code Action"
	},
	{
		k = "K",
		f = vim.lsp.buf.hover,
		d = "Show object dription on hover",
	},
	{
		k = "gd",
		f = vim.lsp.buf.definition,
		d = "Go to the location where the object is defined",
	},
	{
		k = "gt",
		f = vim.lsp.buf.type_definition,
		d = "Go to the definition of the objects type"
	},
	{
		k = "gi",
		f = vim.lsp.buf.implementation,
		d = "Go to the method implementation"
	},
	{
		k = "gl",
		f = vim.lsp.buf.references,
		d = "Go to references of the object"
	},
	{
		k = "]d",
		f = function() vim.diagnostic.jump({ count = 1, float = true }) end,
		d = "Go to the next diagnostic/issue"
	},
	{ -- S is the same as cc, I'd rather use it for something more useful
		k = "[d",
		f = function() vim.diagnostic.jump({ count = -1, float = true }) end,
		d = "Go to the previous diagnostic/issue"
	},
	{
		k = "S",
		f = vim.diagnostic.open_float,
		d = "View diagnostics information in a floating window",
	},
}

-- Bootstrap shortcuts on LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		-- Attach LSP keybinds to the current buffer
		for _, map in ipairs(lsp_keys) do
			vim.keymap.set("n", map.k, map.f, { desc = map.desc, buffer = ev.buf })
		end

		-- Override gq to use built-in text wrapping instead of formatprg
		vim.opt_local.formatprg = ''
		vim.opt_local.formatexpr = ''
	end
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Override formatprg for all files to use built-in text wrapping
vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function()
		vim.opt_local.formatprg = ''
		vim.opt_local.formatexpr = ''
		vim.opt_local.textwidth = 80 -- Force textwidth to 80
	end,
})
