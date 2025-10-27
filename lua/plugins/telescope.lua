--  _       _
-- | |_ ___| | ___  ___  ___ ___  _ __   ___
-- | __/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
-- | ||  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  \__\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|
--
-- Guiding you through a sea of files

vim.pack.add({
	{ src = GH .. 'nvim-lua/plenary.nvim' },
	{
		src = GH .. 'nvim-telescope/telescope.nvim',
		version = vim.version.range('0.1')
	},
	{ src = GH .. 'nvim-telescope/telescope-ui-select.nvim' },
})

local ts = require('telescope')
local tsb = require('telescope.builtin')

ts.setup({
	defaults = {
		borderchars = {
			"─", -- top
			"│", -- right
			"─", -- bottom
			"│", -- left
			"┌", -- top-left
			"┐", -- top-right
			"┘", -- bottom-right
			"└", -- bottom-left
		},
		color_devicons = true,
		path_diwplays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "bottom",
			preview_cutoff = 40,
		}
		-- layout_strategy = "horizontal",
		-- layout_config = {
		-- 	horizontal = {
		-- 		width = 0.95,
		-- 		height = 0.95,
		-- 	},
		-- },
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					['<C-x>'] = require('telescope.actions').delete_buffer,
					['<M-d>'] = false, -- disable the default mapping
				},
				n = {
					['<C-x>'] = require('telescope.actions').delete_buffer,
					['<M-d>'] = false, -- disable the default mapping
				}
			}
		}
	}
})

local ts_keys = {
	{
		k = '<leader>pv',
		f = function()
			tsb.find_files()
		end,
		d = '[P]aruse [F]iles',
	},
	{
		k = '<leader>pb',
		f = function() tsb.buffers() end,
		d = '[P]aruse [b]uffers',
	},
	{
		k = '<leader>pB',
		f = function() tsb.git_branches() end,
		d = '[P]aruse [B]ranches',
	},
	{
		k = '<leader>pd',
		f = function() tsb.diagnostics() end,
		d = '[P]aruse [D]iagnostics',
	},
	{
		k = '<leader>pg',
		f = function() tsb.live_grep() end,
		d = '[P]aruse with [G]rep',
	},
	{
		k = '<leader>ph',
		f = function() tsb.help_tags() end,
		d = '[P]aruse [H]elp',
	},
	{
		k = '<leader>pw',
		f = function()
			tsb.live_grep({
				search_dirs = { vim.fn.expand('%:p') }
			})
		end,
		d = '[P]aruse [W]ithin file',
	},
	{
		k = '<leader>fq',
		f = function()
			tsb.quickfix()
		end,
		d = '[F]ind [Q]uickfix',
	},
	{
		k = '<leader>fr',
		f = function()
			tsb.lsp_references()
		end,
		d = '[F]ind [R]eferences',
	},
	{
		k = '<C-p>',
		f = function()
			if Is_git_repo() then
				tsb.git_files()
			else
				tsb.find_files()
			end
		end,
		d = '[P]aruse Git Files',
	}
}

-- K.ey M.ap
for _, map in ipairs(ts_keys) do
	vim.keymap.set('n', map.k, map.f, { desc = map.d })
end
