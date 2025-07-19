return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
		},
		config = function()
			vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

			vim.diagnostic.config({
				virtual_text = false,
				signs = false,
				underline = false,
				update_in_insert = false,
			})
			-- ================================

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

				if client.name == "ltex" then
					local function set_language(language_id)
						vim.lsp.buf.execute_command({
							command = "ltex.setDocumentLanguage",
							arguments = { uri = vim.uri_from_bufnr(bufnr), languageId = language_id },
							bufnr = bufnr,
						})
						vim.notify("LTeX language set to: " .. language_id, vim.log.levels.INFO)
					end

					vim.keymap.set("n", "<leader>setes", function()
						set_language("es-ES")
					end, { buffer = bufnr, desc = "LTeX: Set language to Spanish" })
					vim.keymap.set("n", "<leader>seten", function()
						set_language("en-US")
					end, { buffer = bufnr, desc = "LTeX: Set language to English" })
				end
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")

			local servers = {
				"ltex",
			}

			mason_lspconfig.setup({
				ensure_installed = servers,
			})

			local lspconfig = require("lspconfig")
			for _, server in ipairs(servers) do
				if server == "ltex" then
					lspconfig.ltex.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							ltex = {
								language = "en-US",
								dictionary = {
									["en-US"] = {},
									["es-ES"] = {},
								},
							},
						},
					})
				else
					lspconfig[server].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end
			end

			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
