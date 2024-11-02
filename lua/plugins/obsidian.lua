return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required:
		"nvim-lua/plenary.nvim",
		-- Optional:
		"dhruvasagar/vim-table-mode",
	},
	config = function()
		local obs = require("obsidian")
		obs.setup({
			workspaces = {
				{
					name = "Main",
					path = "~/Documents/obsidian/main",
				},
			},

			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = true,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},

			conceallevel = 2,

			-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
			-- way then set 'mappings = {}'.
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return obs.util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ot"] = { -- O.bsidian T.ick
					action = function()
						return obs.util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				["<BS>"] = {
					action = function()
						vim.cmd("ObsidianBacklinks")
					end,
					opts = { buffer = true, expr = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
					action = function()
						return obs.util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
				["<leader>r"] = { -- O.bsidian R.ename
					action = function()
						vim.cmd("ObsidianRename")
					end,
					opts = { buffer = true },
				},
				["<leader>oi"] = { -- O.bsidian I.nsert image
					action = function()
						vim.cmd("ObsidianPasteImg")
					end,
					opts = { buffer = true },
				},
				["<leader>os"] = { -- O.bsidian S.earch
					action = function()
						vim.cmd("ObsidianSearch")
					end,
					opts = { buffer = true },
				},
				["<leader>oa"] = { -- O.bsidian t.A.gs
					action = function()
						vim.cmd("ObsidianTags")
					end,
					opts = { buffer = true },
				},
				["<leader>oq"] = { -- O.bsidian Q.uick
					action = function()
						vim.cmd("ObsidianQuickSwitch")
					end,
					opts = { buffer = true },
				},
			},

			-- Either 'wiki' or 'markdown'.
			preferred_link_style = "markdown",

			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
				name = "telescope.nvim",
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},

			-- Optional, sort search results by "path", "modified", "accessed", or "created".
			-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
			-- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
			sort_by = "modified",
			sort_reversed = true,

			-- Optional, configure additional syntax highlighting / extmarks.
			-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
			ui = {
				enable = true, -- set to false to disable all additional syntax features
				update_debounce = 200, -- update delay after a text change (in milliseconds)
				max_file_length = 5000, -- disable UI features for files with more than this many lines
				-- Define how various check-boxes are displayed
				checkboxes = {
					-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					["!"] = { char = "", hl_group = "ObsidianImportant" },
					-- Replace the above with this if you don't have a patched font:
					-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
					-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

					-- You can also add more custom ones...
				},
				-- Use bullet marks for non-checkbox lists.
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				-- Replace the above with this if you don't have a patched font:
				-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
					ObsidianTodo = { bold = true, fg = "#b46958" },
					ObsidianDone = { bold = true, fg = "#586935" },
					ObsidianTag = { italic = true, fg = "#aa749f" },
					ObsidianImportant = { bold = true, fg = "#ab8550" },
					ObsidianBullet = { bold = true, fg = "#576f82" },
					ObsidianRightArrow = { bold = true, fg = "#88afa2" },
					ObsidianHighlightText = { bg = "#d0d0d0" },
					ObsidianTilde = { bold = true, fg = "#aa749f" },
					ObsidianRefText = { underline = true, fg = "#88afa2" },
					ObsidianExtLinkIcon = { fg = "#7e97ab" },
					ObsidianBlockID = { italic = true, fg = "#a2b5c1" },
				},
			},
			-- Specify how to handle attachments.
			attachments = {
				-- The default folder to place images in via `:ObsidianPasteImg`.
				-- If this is a relative path it will be interpreted as relative to the vault root.
				-- You can always override this per image by passing a full path to the command instead of just a filename.
				img_folder = "assets/imgs", -- This is the default

				-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
				---@return string
				img_name_func = function()
					-- Prefix image names with timestamp.
					return string.format("%s-", os.time())
				end,
			},
		})
		vim.opt_local.conceallevel = 2
	end,
}
