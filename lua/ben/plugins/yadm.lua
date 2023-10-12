return {
	"robstumborg/yadm.nvim",
	dependencies = "tpope/vim-fugitive",
	-- Only load if yadm is installed
	cond = function()
		return vim.fn.executable("yadm") == 1
	end,
	config = function()
		require("yadm").setup({
			yadm_dir = vim.fn.expand("$XDG_DATA_HOME/yadm/repo.git"),
		})
	end,
}
