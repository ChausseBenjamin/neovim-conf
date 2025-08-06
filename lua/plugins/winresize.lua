--           _                     _
-- __      _(_)_ __  _ __ ___  ___(_)_______
-- \ \ /\ / / | '_ \| '__/ _ \/ __| |_  / _ \
--  \ V  V /| | | | | | |  __/\__ \ |/ /  __/
--   \_/\_/ |_|_| |_|_|  \___||___/_/___\___|
--
-- Resizing splits the correct way


vim.pack.add({
	{ src = GH .. "simeji/winresizer" },
})

vim.g.winresizer_vert_resize = 13
vim.g.winresizer_horiz_resize = 10

vim.keymap.set("n", "<leader><leader>w", function()
	-- Save current mappings for movement keys
	local saved_mappings = {
		h = FreeMapping("h", "n"),
		j = FreeMapping("j", "n"),
		k = FreeMapping("k", "n"),
		l = FreeMapping("l", "n"),
		K = FreeMapping("K", "n"),
	}

	-- Start winresize
	vim.cmd.WinResizerStartResize()

	-- Create autocmd to restore mappings when winresize ends
	local restore_group = vim.api.nvim_create_augroup("WinresizerRestore", { clear = true })
	vim.api.nvim_create_autocmd("WinClosed", {
		group = restore_group,
		callback = function()
			-- Restore all saved mappings
			for _, mapping in pairs(saved_mappings) do
				RestoreMapping(mapping)
			end
			-- Clean up the autocmd group
			vim.api.nvim_del_augroup_by_id(restore_group)
		end,
		once = true,
	})
end)
