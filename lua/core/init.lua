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
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {}) -- terminal mode Esc

-- Capital "Y" means clipboard now
vim.keymap.set({ "n", "v", "x" }, "Y", '"+y', { desc = "Yank to clipboard", noremap = true })

-- Netrw preferences
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

-- Clear search highlights
vim.keymap.set("n", "<leader><leader>l", function()
	vim.cmd.nohlsearch()
end, { desc = "Clear search highlights" })

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
function Is_git_repo()
	local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")
	if vim.v.shell_error ~= 0 then
		return false
	end
	return git_dir[1]
end

local function cd_to_git_root()
	local git_root = Is_git_repo()
	if git_root then
		vim.cmd("tcd " .. git_root)
	end
end

cd_to_git_root()

-- Quickly compile and preview files
vim.keymap.set("n", "<leader>mm", function()
	vim.cmd.make()
end)
vim.keymap.set("n", "<leader>ma", function()
	vim.cmd.make("all")
end)
vim.keymap.set("n", "<leader>mc", function()
	vim.cmd.make("clean")
end)
vim.keymap.set( -- M.ake O.pen
	"n",
	"<leader>mo",
	function()
		vim.fn.system("opout " .. vim.fn.expand("%"))
	end
)

-- Make sure I don't accidentally delete with 'S' when not using an LSP:
vim.keymap.set("n", "S", "<nop>")
-- Stop hurting my pinky with <C-w>:
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window/Split Management" })
-- Quickly navigate between Tabs
vim.keymap.set("n", "<Bslash>", function()
	vim.cmd.tabnext()
end, { desc = "View next tab" })
vim.keymap.set("n", "<C-\\>", function()
	vim.cmd.tabnew()
end, { desc = "Create a new tab" })
vim.opt.conceallevel = 2
-- Quickly navigate between Buffers
vim.keymap.set("n", "<Tab>", function()
	vim.cmd.bnext()
end, { desc = "View next buffer" })
vim.keymap.set("n", "<S-Tab>", function()
	vim.cmd.bprev()
end, { desc = "View previous buffer" })

function DefaultLspServers()
	return {
		"gopls",
		"golangci_lint_ls",
		"lua_ls",
		"bashls",
		"graphql",
		"texlab",
		"clangd",
		"marksman",
		"dockerls",
		"ruff",
		"docker_compose_language_service",
		"rust_analyzer",
		"zls",
	}
end
