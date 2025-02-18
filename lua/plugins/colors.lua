return {
	{ -- Easy color conversions (rgb, hex, hsl, ...)
		"amadeus/vim-convert-color-to",
		keys = {
			{
				"<leader>ox",
				"<cmd>ConvertColorTo hex<cr>",
				mode = { "n", "x", "o" },
				desc = "C[o]nvert to He[x] (ex: #001122)",
			},
			{
				"<leader>oc",
				"<cmd>ConvertColorTo hex_num<cr>",
				mode = { "n", "x", "o" },
				desc = "C[o]nvert to [C] style int (ex: 0x001122)",
			},
			{
				"<leader>or",
				"<cmd>ConvertColorTo rgb<cr>",
				mode = { "n", "x", "o" },
				desc = "C[o]nvert to [R]gb (ex: rgb(0, 100, 200))",
			},
			{
				"<leader>of",
				"<cmd>ConvertColorTo rgb_float<cr>",
				mode = { "n", "x", "o" },
				desc = "C[o]nvert to [F]loat RGB (ex: rgba(0.1, 0.2, 0.3))",
			},
			{
				"<leader>oh",
				"<cmd>ConvertColorTo hsl<cr>",
				mode = { "n", "x", "o" },
				desc = "C[o]nvert to [H]sl (ex: hsl(200, 20%, 10%))",
			},
		},
	},
	-- { -- Highlight hex/rgb colors inside code
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	config = true,
	-- },
}
