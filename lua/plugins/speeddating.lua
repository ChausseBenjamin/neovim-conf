return {
	{
		"tpope/vim-speeddating",
		event = "BufWritePre",
	},
	{
		"AntonVanAssche/date-time-inserter.nvim",
		config = function()
			local date_time_inserter_status_ok, date_time_inserter = pcall(require, "date-time-inserter")
			if not date_time_inserter_status_ok then
				return
			end
			date_time_inserter.setup({
				date_format = "YYYYMMDD",
				date_separator = "-",
				time_format = 24,
				show_seconds = false,
				-- insert_date_map = "<leader>td", -- T.ime D.ated
				-- insert_time_map = "<leader>tt", -- T.ime T.ime
				-- -- insert_date_time_map = "<leader>dtt",
			})
		end,
		keys = {
			{
				"<leader>td",
				function()
					require("date-time-inserter").insert_date()
				end,
				mode = "n",
				desc = "Insert [T]imestamp [D]ate",
			},
			{
				"<leader>tt",
				function()
					require("date-time-inserter").insert_time()
				end,
				mode = "n",
				desc = "Insert [T]imestamp [T]ime",
			},
			{
				"<leader>tf",
				function()
					require("date-time-inserter").insert_date_time()
				end,
				mode = "n",
				desc = "Insert [T]imestamp [F]ull",
			},
		},
		cmd = { "InsertDate", "InsertTime", "InsertDateTime" },
	},
}
