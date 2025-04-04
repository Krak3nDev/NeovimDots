-- файл: lua/plugins/which.key.lua
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				{
					"<leader>f",
					group = "Telescope",
				},
				{
					"<leader>fb",
					function()
						require("telescope").extensions.file_browser.file_browser()
					end,
					desc = "File Browser",
				},
				{
					"<leader>ff",
					function()
						require("telescope.builtin").find_files()
					end,
					desc = "Find Files",
				},
				{
					"<leader>fg",
					function()
						require("telescope.builtin").git_files()
					end,
					desc = "Git Files",
				},
				{
					"<leader>fo",
					function()
						require("telescope.builtin").oldfiles()
					end,
					desc = "Old Files",
				},
				{
					"<leader>fB",
					function()
						require("telescope.builtin").buffers()
					end,
					desc = "Buffers",
				},
				{
					"<leader>fl",
					function()
						require("telescope.builtin").live_grep()
					end,
					desc = "Live Grep",
				},

				-- Neogit bindings
				{
					"<leader>NG",
					function()
						require("neogit").open() -- Open Neogit status
					end,
					desc = "Neogit Status",
				},
				{
					"<leader>gc",
					function()
						require("neogit").open({ kind = "commit" }) -- Open Neogit commit popup
					end,
					desc = "Neogit Commit",
				},
				{
					"<leader>gs",
					function()
						require("neogit").open({ kind = "split" }) -- Open Neogit as a split
					end,
					desc = "Neogit Split",
				},
			})
		end,
	},
}
