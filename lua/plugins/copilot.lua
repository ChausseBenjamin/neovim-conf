--   ___ ___  _ __ (_) | ___ | |_
--  / __/ _ \| '_ \| | |/ _ \| __|
-- | (_| (_) | |_) | | | (_) | |_
--  \___\___/| .__/|_|_|\___/ \__|
--           |_|
--
-- GitHub Copilot Integration

vim.pack.add {
	{ src = GH .. 'nvim-lua/plenary.nvim' },
	{ src = GH .. 'zbirenbaum/copilot.lua' },
	{ src = GH .. 'CopilotC-Nvim/CopilotChat.nvim' }
}

require('copilot').setup({})

local copilot_chat = require('CopilotChat')

copilot_chat.setup({
	question_header = ' ' .. (vim.fn.getenv('USER') or 'User') .. ': ',
	answer_header = ' Copilot: ',
	error_header = ' Error ',
	separator = '-----',
	model = 'claude-sonnet-4',
})

local copilot_keys = {
	{
		k = '<leader>cc',
		f = '<cmd>CopilotChatToggle<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [C]hat',
	},
	{
		k = '<leader>cd',
		f = '<cmd>CopilotChatDocs<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [D]ocs',
	},
	{
		k = '<leader>ce',
		f = '<cmd>CopilotChatExplain<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [E]xplain',
	},
	{
		k = '<leader>cf',
		f = '<cmd>CopilotChatFix<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [F]ix',
	},
	{
		k = '<leader>cg',
		f = '<cmd>CopilotChatCommit<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [G]it-commit',
	},
	{
		k = '<leader>ch',
		f = '<cmd>CopilotChatReset<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [H]ard Reset',
	},
	{
		k = '<leader>co',
		f = '<cmd>CopilotChatOptimize<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [O]ptimize',
	},
	{
		k = '<leader>cr',
		f = '<cmd>CopilotChatReview<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [R]eview',
	},
	{
		k = '<leader>ct',
		f = '<cmd>CopilotChatTests<cr>',
		m = { 'n', 'v', 'x' },
		d = '[C]opilot [T]ests',
	},
}

for _, map in ipairs(copilot_keys) do
	vim.keymap.set(map.m, map.k, map.f, { desc = map.d })
end
