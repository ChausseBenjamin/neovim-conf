return {
	"ThePrimeagen/vim-apm",
	config = function()
		local apm = require("vim-apm")
		apm:setup({})
	end,
	keys = {
		{ -- Add Harpoon
			"<leader>apm",
			function()
				require("vim-apm"):toggle_monitor()
			end,
			mode = "n",
			desc = "Toggle Action Per Minute",
		},
	},
}
