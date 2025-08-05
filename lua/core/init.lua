--
--   ___ ___  _ __ ___
--  / __/ _ \| '__/ _ \
-- | (_| (_) | | |  __/
--  \___\___/|_|  \___|
--
-- plugin-less sane defaults

vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.encoding = "utf-8"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- ALWAYS start vim from the root of a git repo {{{
-- (helps keeping harpoons consistent)
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
