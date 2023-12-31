-- My Personal Configurations:

-- Superior leader key
vim.g.mapleader = ";"

-- Space is quicker than Shift+Semicolon
vim.keymap.set("n", "<space>", ":")

-- Set encoding to UTF-8
vim.opt.encoding = "utf-8"

-- Do not lazy redraw
vim.opt.lazyredraw = false

-- Display all matching files when tab completing
vim.opt.wildmenu = true

-- Don't show the previously typed command
vim.opt.shortmess:append("c")

-- Set absolute and relative number hybrid
vim.opt.number = true
vim.opt.relativenumber = true

-- View column count
vim.opt.ruler = true

-- Disable the statusline
vim.opt.laststatus = 0

-- Sensible split directions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set tab width and shift width to 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Expanding tabs
vim.opt.expandtab = true

-- Set fold method to marker for Vim folding
vim.opt.foldmethod = "marker"

-- Spelling
vim.opt.complete:append("kspell") -- Better Spell Checking
vim.opt.spelllang = "fr" -- French prose

-- Quickly save
vim.api.nvim_set_keymap("n", "<Leader>w", ":update<CR>", { silent = true })

-- Logical way to Yank
vim.api.nvim_set_keymap("n", "Y", "y$", {})

-- Easily escape terminal mode
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {})

-- Split motion
vim.api.nvim_set_keymap("n", "<C-H>", "<C-w>h", {})
vim.api.nvim_set_keymap("n", "<C-J>", "<C-w>j", {})
vim.api.nvim_set_keymap("n", "<C-K>", "<C-w>k", {})
vim.api.nvim_set_keymap("n", "<C-L>", "<C-w>l", {})

-- Saving and quitting buffers
vim.api.nvim_set_keymap("n", "ZF", "ZQ", {})
vim.api.nvim_set_keymap("n", "<leader>w", ":update<CR>", { silent = true })

-- Enter vim's F.ile M.anager
vim.api.nvim_set_keymap("n", "<leader>fm", ":e .<CR>", { silent = true })

-- Remove trailing white spaces on BufWritePre
vim.cmd([[autocmd BufWritePre * %s/\s\+$//e]])

-- Tree View for the netrw File Manager
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
