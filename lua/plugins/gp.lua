--   __ _ _ __
--  / _` | '_ \
-- | (_| | |_) |
--  \__, | .__/
--  |___/|_|
--
-- AI Chat Assistant with Ollama

vim.pack.add({
	{ src = GH .. "robitx/gp.nvim" }
})

local conf = {
	chat_user_prefix = " " .. (vim.fn.getenv("USER") or "User") .. ":",
	chat_assistant_prefix = { " ", "[{{agent}}]:" },
	providers = {
		openai = { disable = true },
		googleai = { disable = true },
		ollama = { disable = false },
	},
	agents = {
		{ name = "ChatOllamaLlama3", disable = true },
		{ name = "CodeOllamaLlama3", disable = true },
		{
			provider = "ollama",
			name = "ChatOllamaDeepseekCoderV2",
			chat = true,
			command = false,
			model = {
				model = "deepseek-coder-v2",
				num_ctx = 8192,
			},
			system_prompt = "You are a general AI assistant.",
		},
		{
			provider = "ollama",
			name = "CodeOllamaDeepseekCoderV2",
			chat = false,
			command = true,
			model = {
				model = "deepseek-coder-v2",
				temperature = 1.9,
				top_p = 1,
				num_ctx = 8192,
			},
			system_prompt = "You are an AI working as a code editor providing answers.\n\n"
				.. "Use 2 SPACES FOR INDENTATION.\n"
				.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
				.. "START AND END YOUR ANSWER WITH:\n\n```",
		},
	},
	hooks = {
		UnitTests = function(gp, params)
			local template = "I have the following code from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please respond by writing table driven unit tests for the code above."
			local agent = gp.get_chat_agent()
			gp.Prompt(params, gp.Target.vnew, agent, template)
		end,
		Explain = function(gp, params)
			local template = "I have the following code from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please respond by explaining the code above."
			local agent = gp.get_chat_agent()
			gp.Prompt(params, gp.Target.popup, agent, template)
		end,
		CodeReview = function(gp, params)
			local template = "I have the following code from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please analyze for code smells and suggest improvements."
			local agent = gp.get_chat_agent()
			gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
		end,
	},
}

require('gp').setup(conf)

local gp_keys = {
	{
		k = "<leader>a<CR>",
		f = "<cmd>GpChatRespond<cr>",
		m = "n",
		d = "Respond",
	},
	{
		k = "<leader>ac",
		f = "<cmd>GpChatNew<cr>",
		m = "n",
		d = "New [C]hat",
	},
	{
		k = "<leader>at",
		f = "<cmd>GpChatToggle<cr>",
		m = "n",
		d = "[T]oggle Chat",
	},
	{
		k = "<leader>af",
		f = "<cmd>GpChatFinder<cr>",
		m = "n",
		d = "Chat [F]inder",
	},
	{
		k = "<leader>ad",
		f = "<cmd>GpChatDelete<cr>",
		m = "n",
		d = "[D]elete Chat",
	},
	{
		k = "<leader>ac",
		f = ":<C-u>'<,'>GpChatNew<cr>",
		m = "v",
		d = "Visual [C]hat New",
	},
	{
		k = "<leader>at",
		f = ":<C-u>'<,'>GpChatToggle<cr>",
		m = "v",
		d = "Visual [T]oggle Chat",
	},
	{
		k = "<leader>ar",
		f = ":<C-u>'<,'>GpRewrite<cr>",
		m = "v",
		d = "Visual [R]ewrite",
	},
	{
		k = "<leader>aa",
		f = ":<C-u>'<,'>GpAppend<cr>",
		m = "v",
		d = "Visual Append ([a]fter)",
	},
	{
		k = "<leader>ap",
		f = ":<C-u>'<,'>GpPrepend<cr>",
		m = "v",
		d = "Visual [P]repend",
	},
	{
		k = "<leader>ai",
		f = ":<C-u>'<,'>GpImplement<cr>",
		m = "v",
		d = "[I]mplement selection",
	},
	{
		k = "<leader>ae",
		f = ":<C-u>'<,'>GpExplain<cr>",
		m = "v",
		d = "[E]xplain selection",
	},
	{
		k = "<leader>av",
		f = ":<C-u>'<,'>GpCodeReview<cr>",
		m = "v",
		d = "Code Re[v]iew selection",
	},
	{
		k = "<leader>aq",
		f = "<cmd>GpStop<cr>",
		m = { "n", "v", "x" },
		d = "AI [Q]uit",
	},
	{
		k = "<leader>an",
		f = "<cmd>GpNextAgent<cr>",
		m = { "n", "v", "x" },
		d = "AI [N]ext Agent",
	},
}

for _, map in ipairs(gp_keys) do
	vim.keymap.set(map.m, map.k, map.f, { desc = map.d })
end
