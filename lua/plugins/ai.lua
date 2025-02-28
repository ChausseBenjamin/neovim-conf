return {
	{
		"robitx/gp.nvim",
		config = function()
			local conf = {
				chat_user_prefix = " " .. (vim.fn.getenv("USER") or "User") .. ":",
				chat_assistant_prefix = { " ", "[{{agent}}]:" },
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
			require("gp").setup(conf)
		end,
		keys = {
			-- Chat commands
			{
				"<leader>a<CR>",
				"<cmd>GpChatRespond<cr>",
				mode = "n",
				desc = "Respond",
			},
			{
				"<leader>ac",
				"<cmd>GpChatNew<cr>",
				mode = "n",
				desc = "New [C]hat",
			},
			{
				"<leader>at",
				"<cmd>GpChatToggle<cr>",
				mode = "n",
				desc = "[T]oggle Chat",
			},
			{
				"<leader>af",
				"<cmd>GpChatFinder<cr>",
				mode = "n",
				desc = "Chat [F]inder",
			},
			{
				"<leader>ad",
				"<cmd>GpChatDelete<cr>",
				mode = "n",
				desc = "[D]elete Chat",
			},

			{
				"<leader>ac",
				":<C-u>'<,'>GpChatNew<cr>",
				mode = "v",
				desc = "Visual [C]hat New",
			},
			{
				"<leader>at",
				":<C-u>'<,'>GpChatToggle<cr>",
				mode = "v",
				desc = "Visual [T]oggle Chat",
			},

			-- Prompt commands
			{
				"<leader>ar",
				":<C-u>'<,'>GpRewrite<cr>",
				mode = "v",
				desc = "Visual [R]ewrite",
			},
			{
				"<leader>aa",
				":<C-u>'<,'>GpAppend<cr>",
				mode = "v",
				desc = "Visual Append ([a]fter)",
			},
			{
				"<leader>ap",
				":<C-u>'<,'>GpPrepend<cr>",
				mode = "v",
				desc = "Visual [P]repend",
			},

			-- Hooks
			{
				"<leader>ai",
				":<C-u>'<,'>GpImplement<cr>",
				mode = "v",
				desc = "[I]mplement selection",
			},
			{
				"<leader>ae",
				":<C-u>'<,'>GpExplain<cr>",
				mode = "v",
				desc = "[E]xplain selection",
			},
			{
				"<leader>av",
				":<C-u>'<,'>GpCodeReview<cr>",
				mode = "v",
				desc = "Code Re[v]iew selection",
			},
			{
				"<leader>aq",
				"<cmd>GpStop<cr>",
				mode = { "n", "v", "x" },
				desc = "AI [Q]uit",
			},
			{
				"<leader>an",
				"<cmd>GpNextAgent<cr>",
				mode = { "n", "v", "x" },
				desc = "AI [N]ext Agent",
			},
		},
	},
	{
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			dependencies = {
				{ "zbirenbaum/copilot.lua" },
				{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
			},
			build = "make tiktoken", -- Only on MacOS or Linux
			opts = {
				question_header = " " .. (vim.fn.getenv("USER") or "User") .. ": ", -- Header to use for user questions
				answer_header = " Copilot: ", -- Header to use for AI answers
				error_header = " Error ", -- Header to use for errors
				separator = "-----", -- Separator to use in chat
				-- See Configuration section for options
			},
			-- See Commands section for default commands if you want to lazy load on them
		},
	},
}
