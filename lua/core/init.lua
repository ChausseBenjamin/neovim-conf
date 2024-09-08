vim.g.mapleader = " "
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.wildmenu = true -- Show mathes with tab-completion
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.lazyredraw = true
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.foldmethod = "marker" --- For `{{{` & `}}}` folding
vim.opt.complete:append("kspell")
vim.opt.inccommand = "split"
vim.opt.spelllang = "fr" -- why does french exist...
vim.api.nvim_set_keymap("n", "Y", "y$", {}) -- What should have been `Y`
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {}) -- terminal mode Esc

-- TODO: turn this into a plugin? (count + single undo)
vim.keymap.set("v", "<s-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<s-k>", ":m '<-2<cr>gv=gv")

-- Netrw preferences
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

-- Clear search highlights
vim.keymap.set("n", "<leader><leader>l", "<cmd>nohlsearch<cr>")

-- Don't mess with pasted text
vim.keymap.set("i", "<C-r>+", "<C-r><C-o>+")

-- Remove trailing whitespace (exept current line to avoid moving cursor)
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Auto cd to git root of project (good for harpoon)
local function is_git_repo()
	local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")
	if vim.v.shell_error ~= 0 then
		return false
	end
	return git_dir[1]
end

local function cd_to_git_root()
	local git_root = is_git_repo()
	if git_root then
		vim.cmd("tcd " .. git_root)
	end
end

cd_to_git_root()

-- Quickly compile and preview files
vim.keymap.set("n", "<leader>mm", "<cmd>make<cr>") -- M.ake
vim.keymap.set("n", "<leader>ma", "<cmd>make<cr>") -- M.ake A.ll
vim.keymap.set("n", "<leader>mc", "<cmd>make<cr>") -- M.ake C.lean
vim.keymap.set("n", "<leader>mo", "<cmd>!opout %<cr>") -- M.ake O.pen

-- Make sure I don't accidentally delete with 'S' when not using an LSP:
vim.keymap.set("n", "S", "<nop>")
-- Stop hurting my pinky with <C-w>:
vim.keymap.set("n", "<leader>w", "<C-w>")
-- Quickly navigate between Tabs
vim.keymap.set("n", "<Bslash>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<C-\\>", "<cmd>tabnew<cr>")
