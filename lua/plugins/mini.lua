return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		local withDefaults = {
			"ai",
			"align",
			"bracketed",
			"comment",
			"indentscope",
			"jump",
			"move",
			"operators",
			"splitjoin",
			"trailspace",
			"surround",
		}
		for _, pkg in ipairs(withDefaults) do
			require("mini." .. pkg).setup()
		end
	end,
}
