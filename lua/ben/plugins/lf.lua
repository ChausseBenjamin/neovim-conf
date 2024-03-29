return {
  "lmburns/lf.nvim",
  lazy = false,
  dependencies = {
    { "akinsho/toggleterm.nvim", version = "*", config = true },
  },
  config = function()
    vim.g.lf_netrw = 1
    local lf = require("lf").setup({
      border = "rounded",
      focus_on_open = true,
    })
    vim.api.nvim_set_keymap("n", "<leader>lf", "<cmd>Lf<cr>", { noremap = true, silent = true })
  end,
}
