return {
	"oysandvik94/curl.nvim",
	cmd = {
		"CurlOpen",
		"CurlCollection",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		open_with = "split",
	},
	keys = {
		{ -- CUrl
			"<leader>cu",
			function()
				require("curl").open_curl_tab()
			end,
			mode = "n",
			desc = "Open a curl tab scoped to the current working directory",
		},
		{ -- C.url O.pen
			"<leader>co",
			function()
				require("curl").open_global_tab()
			end,
			mode = "n",
			desc = "Open a curl tab with gloabl scope",
		},
		-- These commands will prompt you for a name for your collection
		{ -- C.url S.coped C.ollection
			"<leader>csc",
			function()
				require("curl").create_scoped_collection()
			end,
			mode = "n",
			desc = "Create or open a collection with a name from user input",
		},
		{ -- C.url G.lobal C.ollection
			"<leader>cgc",
			function()
				require("curl").create_global_collection()
			end,
			mode = "n",
			desc = "Create or open a global collection with a name from user input",
		},
		{ -- P.aruse C.url S.coped
			"<leader>pcs",
			function()
				require("curl").pick_scoped_collection()
			end,
			mode = "n",
			desc = "Choose a scoped collection and open it",
		},
		{ -- P.aruse C.url G.lobal
			"<leader>pcg",
			function()
				require("curl").pick_global_collection()
			end,
			mode = "n",
			desc = "Choose a global collection and open it",
		},
	},
}
