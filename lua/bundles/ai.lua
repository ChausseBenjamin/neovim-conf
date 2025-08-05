--         _
--   __ _ (_)
--  / _` || |
-- | (_| || |
--  \__,_||_|
--
-- AI Assistant Bundle

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
	callback = function()
		require('plugins.gp')
		require('plugins.copilot')
	end
})
