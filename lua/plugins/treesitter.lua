return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			---@diagnostic disable-next-line: missing-fields
			configs.setup({
				-- List of languages in-> :h
				ensure_installed = {
					"bash",
					"c",
					"dockerfile",
					"gitignore",
					"go",
					"graphql",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"mermaid",
					"python",
					"query",
					"r",
					"rnoweb",
					"rust",
					"sxhkdrc",
					"vhs",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
					"zathurarc",
					"zig",
				},
				ignore_install = {
					"javascript",
					"typescript",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = false },
				additional_vim_regex_highlighting = false,
				textobjects = {
					swap = {
						enable = true,
						swap_next = {
							["<leader>s"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>S"] = "@parameter.inner",
						},
					},
					-- Mnemonics used:
					--   - f -> function call start
					--   - F -> function call end
					--   - m -> meat as in the meat of the function (without definition)
					--   - o -> loop
					-- Notes:
					move = {
						enable = true,
						set_jumps = true,

						goto_next_start = {
							["]f"] = "@function.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
						},

						goto_previous_start = {
							["[f"] = "@function.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
						},

						goto_next = {
							["]m"] = "@function.inner",
							["]o"] = "@loop.inner",
							["]O"] = "@loop.outer",
						},
						goto_previous = {
							["[m"] = "@function.inner",
							["[o"] = "@loop.inner",
							["[O"] = "@loop.outer",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			-- next and previous with `;` (next) and `,` (previous)
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
			-- Also use `;` and `,` with the default vim `f` and `F`
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},
}
