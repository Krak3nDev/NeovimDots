return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Basic LSP mappings (diagnostics, hover, etc.)
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "Basic LSP mappings for the current buffer",
				callback = function(event)
					local bufnr = event.buf
					local opts = { silent = true, buffer = bufnr }

					-- Hover and diagnostics
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "<C-w>d", vim.diagnostic.open_float, opts)
				end,
			})

			-- Disable Ruff hoverProvider in favor of Pyright
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client == nil then
						return
					end
					if client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
					end
				end,
				desc = "LSP: Disable hover capability from Ruff",
			})

			-- Additional keybindings as per your table
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttach_MyKeys", { clear = true }),
				callback = function(args)
					local bufnr = args.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs,
							{ silent = true, buffer = bufnr, desc = desc })
					end

					-- <leader>cl : Lsp Info
					map("n", "<leader>cl", "<cmd>LspInfo<CR>", "LSP Info")

					-- gd / gr / gI / gy / gD
					map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
					map("n", "gr", vim.lsp.buf.references, "Go to References")
					map("n", "gI", vim.lsp.buf.implementation, "Go to Implementation")
					map("n", "gy", vim.lsp.buf.type_definition, "Go to Type Definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")

					-- gK / <c-k> : Signature Help
					map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
					map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help (insert)")

					-- <leader>ca : Code Action (normal/visual)
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

					-- <leader>cc : Run CodeLens (normal/visual)
					map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, "Run CodeLens")

					-- <leader>cC : Refresh (and optionally run) CodeLens
					map("n", "<leader>cC", function()
						vim.lsp.codelens.refresh()
						-- If you want to automatically run them after refresh:
						-- vim.lsp.codelens.run()
					end, "Refresh CodeLens")

					-- <leader>cR : Rename File (placeholder)
					map("n", "<leader>cR", function()
						vim.notify("Rename File not implemented (depends on language/server)",
							vim.log.levels.INFO)
					end, "Rename File")

					-- <leader>cr : Rename symbol
					map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")

					-- <leader>cA : Source Action
					map("n", "<leader>cA", function()
						vim.lsp.buf.code_action({ context = { only = { "source" } }, apply = true })
					end, "Source Action")

					-- ]] / [[ / <A-n> / <A-p> : Next/Prev Reference (placeholder)
					map("n", "]]", function()
						vim.notify("Next reference not implemented (use quickfix or a plugin)",
							vim.log.levels.INFO)
					end, "Next Reference")

					map("n", "[[", function()
						vim.notify(
						"Previous reference not implemented (use quickfix or a plugin)",
							vim.log.levels.INFO)
					end, "Previous Reference")

					map("n", "<A-n>", function()
						vim.notify("Next reference not implemented (use quickfix or a plugin)",
							vim.log.levels.INFO)
					end, "Next Reference")

					map("n", "<A-p>", function()
						vim.notify(
						"Previous reference not implemented (use quickfix or a plugin)",
							vim.log.levels.INFO)
					end, "Previous Reference")
				end,
			})

			-- Configure servers via mason-lspconfig.setup_handlers()
			require("mason-lspconfig").setup_handlers({
				-- 1) Default handler for any server not specified below
				function(server_name)
					lspconfig[server_name].setup({})
				end,

				-- 2) Pyright: Use Ruff for organizeImports and lint
				["pyright"] = function()
					lspconfig.pyright.setup({
						settings = {
							pyright = {
								disableOrganizeImports = true, -- Delegates organize imports to Ruff
							},
							python = {
								analysis = {
									ignore = { "*" }, -- Delegate linting to Ruff
									typeCheckingMode = "strict",
									autoImportCompletions = true,
								},
							},
						},
					})
				end,

				-- 3) Ruff
				["ruff"] = function()
					lspconfig.ruff.setup({
						init_options = {
							settings = {
								configurationPreference = "filesystemFirst",
							},
						},
					})
				end,
			})

			-- Automatically apply "Fix all" and "Organize imports" on save for Python
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.py" },
				desc = "Ruff: Fix all & Organize imports on save",
				callback = function()
					vim.lsp.buf.code_action({
						context = {
							only = { "source.fixAll", "source.organizeImports" },
						},
						apply = true, -- Apply automatically
					})
				end,
			})
		end,
	},
}

