return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Para markdown, es recomendable instalar ambos parsers
				ensure_installed = { "markdown", "markdown_inline" },

				-- Instalar parsers de forma síncrona (solo se aplica a `ensure_installed`)
				sync_install = false,

				-- Instalar automáticamente los parsers que falten al entrar en un buffer
				-- Recomendación: ponlo en `false` si no tienes `tree-sitter` CLI instalado localmente
				auto_install = true,

				highlight = {
					-- `false` desactiva todo el resaltado de nvim-treesitter
					enable = true,

					-- Para markdown, a veces es útil usar el resaltado de regex de Vim.
					-- Si tienes problemas con el resaltado, puedes probar a añadir 'markdown' aquí.
					additional_vim_regex_highlighting = { "markdown" },
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}
