--            _       _
--  _ __ ___ (_)_ __ (_)
-- | '_ ` _ \| | '_ \| |
-- | | | | | | | | | | |
-- |_| |_| |_|_|_| |_|_|
--
-- The plugin that's anything but mini

vim.pack.add({
	{ src = GH .. "nvim-treesitter/nvim-treesitter" },
	{ src = GH .. "echasnovski/mini.nvim" },
})

-- plugin parts for which the defaults are ok
local mini_defaults = {
	"align",
	"operators",
	"surround",
}
for _, pkg in ipairs(mini_defaults) do
	require("mini." .. pkg).setup()
end

-- Animations and delay were annoying for this one
local no_indent_anim = require("mini.indentscope").gen_animation.none
require("mini.indentscope").setup({
	draw = {
		delay = 0,
		animation = no_indent_anim(),
	},
})

-- Better "A"round/"I"nner  + Custom treesitter mappings
local gen_spec = require("mini.ai").gen_spec
require("mini.ai").setup({
	n_lines = 300,
	custom_textobjects = {
		F = gen_spec.treesitter({ -- `f` is for function calls not definitions
			a = "@function.outer",
			i = "@function.inner",
		}),
		o = gen_spec.treesitter({
			a = "@loop.outer",
			i = "@loop.inner",
		}),
		c = gen_spec.treesitter({
			a = "@conditional.outer",
			i = "@conditional.inner",
		}),
		C = gen_spec.treesitter({
			a = "@class.outer",
			i = "@class.inner",
		}),
	},
})

require("mini.bracketed").setup({
	-- Disable what's unnecessary or overlaps
	file = { suffix = "", options = {} },
	oldfile = { suffix = "", options = {} },
	undo = { suffix = "", options = {} },
	window = { suffix = "", options = {} },
	yank = { suffix = "", options = {} },
	treesitter = { suffix = "", options = {} },

	-- `c` already used by treesitter-textobjects
	comment = { suffix = "g", options = {} },
	quickfix = { suffix = "q", options = { wrap = false } },
})
