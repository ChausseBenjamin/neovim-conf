return {
	enabled = false,
	"APZelos/blamer.nvim",
	config = function()
		vim.g.blamer_enabled = 1
		vim.g.blamer_delay = 500
		vim.g.blamer_template = "<committer>, <committer-time> • <summary>"
		vim.g.blamer_prefix = ">"
	end,
	cond = function()
		return vim.fn.has("linux") == 1
	end,
}