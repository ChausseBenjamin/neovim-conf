-- Configure the compiler for latex

local function tex_root()
	return vim.fn.system('grep -rl -m 1 --include "*.tex" "documentclass"')
end

vim.opt_local.makeprg = "pdflatex -interaction=nonstopmode -file-line-error -synctex=1 " .. tex_root()
