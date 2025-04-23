return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
		{ "mike-jl/harpoonEx", opts = { reload_on_dir_change = true } },
	},
	config = function()
		local hp = require("harpoon")
		local hpx = require("harpoonEx")
		hp:extend(hpx.extend())
		hp.setup({})
	end,
	keys = {
		{ -- add [H]arpoon
			"<leader>h",
			function()
				require("harpoon"):list():add()
				vim.print("Harpoon added!")
			end,
			mode = "n",
			desc = "Add Harpoon",
		},
		{ -- [E]dit Harpoons
			"<C-e>",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			mode = "n",
			desc = "Edit Harpoons",
		},
		{ -- [S]elect Harpoon 1
			"<C-h>",
			function()
				require("harpoon"):list():select(1)
			end,
			mode = "n",
			desc = "Select Harpoon 1",
		},
		{ -- Select Harpoon 2
			"<C-j>",
			function()
				require("harpoon"):list():select(2)
			end,
			mode = "n",
			desc = "Select Harpoon 2",
		},
		{ -- Select Harpoon 3
			"<C-k>",
			function()
				require("harpoon"):list():select(3)
			end,
			mode = "n",
			desc = "Select Harpoon 3",
		},
		{ -- Select Harpoon 4
			"<C-l>",
			function()
				require("harpoon"):list():select(4)
			end,
			mode = "n",
			desc = "Select Harpoon 4",
		},
		{ -- Select Harpoon 5
			"<C-;>",
			function()
				require("harpoon"):list():select(5)
			end,
			mode = "n",
			desc = "Select Harpoon 5",
		},
		{ -- Select Previous Harpoon
			"<C-S-P>",
			function()
				require("harpoon"):list():prev()
			end,
			mode = "n",
			desc = "Select Previous Harpoon",
		},
		{ -- Select Next Harpoon
			"<C-S-N>",
			function()
				require("harpoon"):list():next()
			end,
			mode = "n",
			desc = "Select [N]ext Harpoon",
		},
	},
}
