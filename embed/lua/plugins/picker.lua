return {
	"nvim-telescope/telescope.nvim",
	-- Se recomienda cargar Telescope de forma perezosa (lazy)
	-- se activará con los comandos o atajos de teclado.
	cmd = "Telescope",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>/",
			function()
				-- Equivalente a Snacks.picker.grep()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep (Telescope)",
		},
		{
			"<leader>ff",
			function()
				-- Equivalente a Snacks.picker.files() con archivos ocultos
				-- La opción `hidden = true` en Telescope muestra los archivos ocultos.
				require("telescope.builtin").find_files({ hidden = true })
			end,
			desc = "Find Files (Telescope)",
		},
		{
			"<leader>fw",
			function()
				-- Equivalente a Snacks.picker.grep_word()
				-- Busca la palabra bajo el cursor o la selección visual.
				require("telescope.builtin").grep_string()
			end,
			desc = "Grep word/selection (Telescope)",
			mode = { "n", "x" },
		},
		{
			"<leader>st", -- O el atajo que prefieras
			function()
				-- Equivalente a tu buscador de tags personalizado.
				require("telescope.builtin").live_grep({
					prompt_title = "Buscar Tags en Markdown",
					-- `default_text` rellena la búsqueda inicial en el prompt.
					default_text = "#",
					-- `additional_args` añade argumentos al comando `ripgrep` subyacente.
					additional_args = function(args)
						return vim.list_extend(args, {
							"-g",
							"*.md", -- Busca solo en archivos markdown
							"-i", -- Búsqueda sin distinguir mayúsculas/minúsculas
						})
					end,
				})
			end,
			desc = "Search Tags (Telescope)",
		},
	},
}
