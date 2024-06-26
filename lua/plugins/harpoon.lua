return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()

    -- Cd to git root on startup to retain harpoons wherever vim starts
    local  function is_git_repo()
      local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")
      if vim.v.shell_error ~= 0 then
          return false
      end
      return git_dir[1]
    end

    local function cd_to_git_root()
      local git_root = is_git_repo()
      if git_root then
        vim.cmd('tcd ' .. git_root)
      end
    end

    cd_to_git_root()

    local harpoon = require("harpoon")

    harpoon:setup()

    -- harpoon keybindings
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end )
    -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, {desc = "Open harpoon window"} )
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end )

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1)end )
    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2)end )
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3)end )
    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4)end )
    vim.keymap.set("n", "<C-;>", function() harpoon:list():select(5)end )

    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end,
}
