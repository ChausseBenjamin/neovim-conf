return {
	dev = true,
	"ChausseBenjamin/dropship.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	opts = {
		new_tab_explorer = false, -- Set to true to use `:Exp` on new tabs
		drop_locations = "~/.cache/nvim-dropsites.lua",
	},
	keys = {
		{
			"<leader>dt",
			function() -- creates a new tab, then uses `:tcd`
				require("dropship").new_tab()
			end,
			mode = "n",
			desc = "[D]ropship in a new [T]ab",
		},
		{
			"<leader>dc",
			function() -- uses `:tcd` on current tab
				require("dropship").current_tab()
			end,
			mode = "n",
			desc = "[D]ropship [C]urrent tab",
		},
		{
			"<leader>de",
			function() -- uses `:cd`
				require("dropship").globally()
			end,
			mode = "n",
			desc = "[D]ropship [E]verywhere",
		},
		{
			"<leader>dg",
			function() -- uses `:cd`
				require("dropship").new_tab({
					drop_locations = {
						{ name = "CPROC Charts", dir = "~/Workspace/cproc-charts/master" },
						{ name = "Datacenter", dir = "~/Workspace/datacenter/datacenter" },
						{ name = "DC Management", dir = "~/Workspace/dc_management/master" },
						{ name = "DockerPBX", dir = "~/Workspace/dockerpbx/master" },
						{ name = "GitOps", dir = "~/Workspace/gitops-voice-platform" },
						{ name = "Go Logger", dir = "~/Workspace/go-logger" },
						{ name = "Prodtools", dir = "~/Workspace/jive-utils" },
						{ name = "Monorepo", dir = "~/Workspace/monorepo-go/master" },
						{ name = "Integration Tests", dir = "~/Workspace/python-integration-test-common" },
						{ name = "Termpicker", dir = "~/Workspace/termpicker" },
					},
				})
				require("telescope.builtin").git_files()
			end,
			mode = "n",
			desc = "[D]ropship [G]it Projects",
		},
	},
	cmd = {
		"DropshipCurrentTab",
		"DropshipNewTab",
		"DropshipGlobalDir",
	},
}
