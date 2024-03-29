return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neorg/neorg-telescope",
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.export"] = {}, -- Loads default behaviour
        ["core.concealer"] = {
          config = {
            icons = {
              heading = {
                icons = {
                  "",
                  "",
                  "",
                  "",
                },
              },
            },
          },
        }, -- Adds pretty icons to your documents
        ["core.integrations.telescope"] = {},
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Dropbox/org",
            },
            default_workspace = "notes",
          },
        },
      },
    })
  end,
}
