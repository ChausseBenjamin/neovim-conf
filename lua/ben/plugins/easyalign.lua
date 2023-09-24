return {
	"junegunn/vim-easy-align",
	event = { "BufRead", "BufNewFile" },
	config = function()
		-- Start interactive EasyAlign in visual mode (e.g., vipga)
		vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
		-- Start interactive EasyAlign for a motion/text object (e.g., gaip)
		vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
	end,
}
