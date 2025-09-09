--        _
--  _   _(_)
-- | | | | |
-- | |_| | |
--  \__,_|_|
--
-- Making things pretty

vim.pack.add({
	{ src = GH .. "aktersnurra/no-clown-fiesta.nvim" },
	{ src = GH .. "stevearc/dressing.nvim" },
	{ src = GH .. "nvim-tree/nvim-web-devicons" },
})

-- UI tweaks
require('plugins.treesitter')
require('plugins.lualine')
vim.o.winborder = "rounded"

-- Setup must come before loading the colorscheme
require("no-clown-fiesta").setup({
	transparent = true,
	styles = {
		type = { bold = true },
		lsp = { underline = true },
		keywords = { italic = true },
	},
})

local plt = {
	white = "#f2f1f0",
	gray = "#727272",
	yellow = "#BAB382",
	red = "#84493b",
	blue = "#374758",
	dark = "#111a1f",
	void = "none",
}

vim.cmd.colorscheme("no-clown-fiesta")

-- Tweaks to the stock colorscheme
vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = plt.gray})
vim.api.nvim_set_hl(0, "Folded", { bg =  plt.void})
vim.api.nvim_set_hl(0, "Visual", { bg = plt.blue})
vim.api.nvim_set_hl(0, "VertSplit", { bg = plt.void, fg = plt.gray})
vim.api.nvim_set_hl(0, "WinSeparator", { bg = plt.void, fg = plt.gray})
vim.api.nvim_set_hl(0, "StatusLine", { bg = plt.void, fg = plt.gray})

vim.api.nvim_set_hl(0, "ColorColumn", { bg = plt.red})
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = plt.blue})
vim.fn.matchadd("ColorColumn", "\\%82v", 100)

vim.api.nvim_set_hl(0, "Search", { bg = plt.dark, fg = plt.yellow})
vim.api.nvim_set_hl(0, "CurSearch", { bg = plt.blue, fg = plt.white})
