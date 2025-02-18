return {
	"robitx/gp.nvim",
	config = function()
		local local_user = vim.fn.getenv("USER") or "User"
		local conf = {
			chat_user_prefix = " " .. local_user .. ":",
			chat_assistant_prefix = { "󰚩 ", "[{{agent}}]:" },
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
		}
		require("gp").setup(conf)
	end,
}
