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
	"rustowl",
	"zls"
})

-- Load more stuff now that the lsp is installed
require('plugins.blink')
require('plugins.rustowl')


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

-- Configure rust_analyzer
vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true
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
			vim.keymap.set("n",map.k,map.f,{desc = map.desc, buffer = ev.buf})
		end
	end,
})

