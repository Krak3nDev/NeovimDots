return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
			},
		},
		config = function()
			local telescope = require("telescope")
			local themes = require("telescope.themes")
			local fb_actions = telescope.extensions.file_browser.actions

			local ivy_with_ignore = themes.get_ivy({
				layout_config = {
					width = 0.8,
					prompt_position = "bottom",
				},
				previewer = false,
				file_ignore_patterns = {
					"__pycache__",
					"%.mypy_cache",
					"%.pytest_cache",
					"%.ruff_cache",
					"%.venv",
					"%.git",
					"%.idea",
				},
				path_display = { "smart" }
			})

			telescope.setup({
				defaults = ivy_with_ignore,
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					file_browser = {
						hijack_netrw = true,
						theme = "ivy",
						hidden = false,
						respect_gitignore = false,
						mappings = {
							["n"] = {
								["H"] = fb_actions.toggle_hidden,
								["d"] = fb_actions.change_cwd,
								["c"] = fb_actions.create,
								["D"] = fb_actions.remove
							},
							["i"] = {
								["<C-h>"] = fb_actions.toggle_hidden,
								["<C-d>"] = fb_actions.change_cwd,
								["<C-c>"] = fb_actions.create,
								["<C-D>"] = fb_actions.remove,
							},
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
		end,
	},
}
