return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer with Conform",
		},
	},
	opts = {
		formatters_by_ft = {
			python = {
				"ruff_fix",
				"ruff_format",
				"ruff_organize_imports",
			},
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 500 },
		formatters = {
			ruff_fix = {
				command = "ruff",
				args = { "check", "--fix", "-" },
				stdin = true,
			},
			ruff_format = {
				command = "ruff",
				args = { "format", "-" },
				stdin = true,
			},
			ruff_organize_imports = {
				command = "ruff",
				args = { "check", "--select", "I", "--fix", "-" },
				stdin = true,
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
