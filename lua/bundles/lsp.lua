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
DevPack('mrcjkb/rustaceanvim')

vim.lsp.enable({
	'gopls',
	'golangci_lint_ls',
	'lua_ls',
	'bashls',
	'ruff',
	'zls',
	'tinymist',
	-- No 'rust_analyzer' as it's handled by rustaceanvim
})

-- Use nvim-lspconfig for texlab to get commands like :TexlabBuild
require('lspconfig').texlab.setup({
	settings = {
		texlab = {
			build = {
				executable = 'pdflatex',
				args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
				onSave = true, -- Set to true for auto-build on save
				forwardSearchAfter = false,
			},
			chktex = {
				onOpenAndSave = true, -- Enable linting
				onEdit = false,
			},
		},
	},
})

vim.g.rustaceanvim = {
	server = {
		default_settings = {
			['rust-analyzer'] = {
				checkOnSave = false,
				check = {
					command = "check",
					allTargets = false,
					features = {},
					noDefaultFeatures = false,
				},
				numThreads = tonumber(vim.fn.system('getconf _NPROCESSORS_ONLN')) or 4,
				cachePriming = {
					enable = false,
				},
				procMacro = {
					enable = true,
				},
				cargo = {
					buildScripts = {
						enable = true,
						rebuildOnSave = true,
					},
					targetDir = true,
					autoreload = true,
				},
				lru = {
					capacity = 512,
				},
				diagnostics = {
					experimental = {
						enable = false,
					},
				},
				files = {
					watcher = "client",
				},
			},
		},
	},
	tools = {
		test_executor = "background",
	},
}


-- Load more stuff now that the lsp is installed
require('plugins.blink')

-- tweaks to mute lua errors in the Neovim config:
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true)
			}
		}
	}
})

-- Configure tinymist for PDF export on type
vim.lsp.config('tinymist', {
	settings = {
		exportPdf = "onType",
		outputPath = "$root/target/$dir/$name",
		formatterMode = "typstyle",
	}
})

-- Custom hover function to show images or LSP hover
local function custom_hover()
	-- Check if cursor is on a typst image path using line regex
	local line = vim.fn.getline('.')
	local col = vim.fn.col('.')
	local image_path = nil

	-- Match #image("path") or image("path")
	local pattern = '#?image%("([^"]+)"'
	local start, end_pos, path = line:find(pattern)
	if start and col >= start and col <= end_pos then
		image_path = path
	end

	if not image_path then
		vim.lsp.buf.hover()
		return
	end

	-- Resolve path relative to current file
	local file_dir = vim.fn.expand('%:p:h')
	local full_path = file_dir .. '/' .. image_path
	if not vim.fn.filereadable(full_path) then
		print('not readable, calling hover')
		vim.lsp.buf.hover()
		return
	end

	-- Create floating window popup for the image
	local api = require('image')
	local ok, image = pcall(api.from_file, full_path, {})
	if not ok or not image then
		vim.lsp.buf.hover()
		return
	end

	local utils = require('image/utils')
	local term_size = utils.term.get_size()
	local width, height = utils.math.adjust_to_aspect_ratio(
		term_size,
		image.image_width,
		image.image_height,
		math.floor(term_size.screen_cols / 2),
		0
	)
	local win_config = {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	}
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].filetype = "image_nvim_popup"
	local win = vim.api.nvim_open_win(buf, false, win_config)

	image.ignore_global_max_size = true
	image.window = win
	image.buffer = buf

	vim.defer_fn(function()
		if vim.api.nvim_win_is_valid(win) then
			local win_info = vim.fn.getwininfo(win)[1]
			if win_info and win_info.wincol > 0 then
				image:render({
					x = 0,
					y = 0,
					width = width,
					height = height,
				})
			end
		end
	end, 10)

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		callback = function()
			if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
			image:clear()
		end,
		once = true,
	})
end

local lsp_keys = {
	{
		k = '<leader>r',
		f = vim.lsp.buf.rename,
		d = 'Rename object across all occurences'
	},
	{
		k = '<leader>fa',
		f = vim.lsp.buf.code_action,
		d = 'Run code Action'
	},
	{
		k = 'K',
		f = custom_hover,
		d = 'Show object description or image on hover',
	},
	{
		k = 'gd',
		f = vim.lsp.buf.definition,
		d = 'Go to the location where the object is defined',
	},
	{
		k = 'gt',
		f = vim.lsp.buf.type_definition,
		d = 'Go to the definition of the objects type'
	},
	{
		k = 'gi',
		f = vim.lsp.buf.implementation,
		d = 'Go to the method implementation'
	},
	{
		k = 'gl',
		f = vim.lsp.buf.references,
		d = 'Go to references of the object'
	},
	{
		k = ']d',
		f = function() vim.diagnostic.jump({ count = 1, float = true }) end,
		d = 'Go to the next diagnostic/issue'
	},
	{ -- S is the same as cc, I'd rather use it for something more useful
		k = '[d',
		f = function() vim.diagnostic.jump({ count = -1, float = true }) end,
		d = 'Go to the previous diagnostic/issue'
	},
	{
		k = 'S',
		f = vim.diagnostic.open_float,
		d = 'View diagnostics information in a floating window',
	},
}

-- Bootstrap shortcuts on LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		-- Attach LSP keybinds to the current buffer
		for _, map in ipairs(lsp_keys) do
			vim.keymap.set('n', map.k, map.f, { desc = map.desc, buffer = ev.buf })
		end

		-- Override gq to use built-in text wrapping instead of formatprg
		vim.opt_local.formatprg = ''
		vim.opt_local.formatexpr = ''
	end
})

-- Populate quickfix with diagnostics on LSP notify
vim.api.nvim_create_autocmd('LspNotify', {
	callback = function(args)
		if args.data.method == 'textDocument/publishDiagnostics' then
			vim.diagnostic.setqflist()
		end
	end,
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
	callback = function()
		local orig_notify = vim.notify
		---@diagnostic disable-next-line: duplicate-set-field
		vim.notify = function(_, _) end
		vim.lsp.buf.format({ async = false })
		vim.notify = orig_notify
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
