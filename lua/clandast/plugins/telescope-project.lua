return {
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("project")
			vim.keymap.set("n", "<leader>p", function()
				require("telescope").extensions.project.project({})
			end, { noremap = true, silent = true, desc = "Open Project Picker" })
		end,
	},
}
