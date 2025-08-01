return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = { "BufReadPre *.md", "BufNewFile *.md" },
	dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },

	opts = {
		-- 1. USA UNA RUTA ABSOLUTA Y FIJA a tu carpeta de notas.
		-- Reemplaza "~/wiki" con la ruta real a tus notas.
		-- vim.fn.expand se asegura de que "~" se convierta a tu home directory.
		workspaces = {
			{
				name = "tanso",
				path = vim.fn.getcwd(),
			},
		},

		-- 2. DESACTIVA COMPLETAMENTE LA GENERACIÓN DE METADATOS (YAML Frontmatter)
		-- Al crear una nota nueva, no se añadirá NADA. El archivo estará vacío.
		note_frontmatter_func = function(note)
			-- Por defecto, esto añade id, fecha, etc.
			-- Al devolver una tabla vacía, lo desactivamos.
			return {}
		end,

		note_id_func = function(note)
			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""

			-- Buscar el link activo alrededor del cursor (funciona dentro del [[...]])
			local link_start = line:sub(1, col):match("%[%[([^%[%]]*)$")
			local link_end = line:sub(col + 1):match("^([^%[%]]*)%]%]")

			if link_start or link_end then
				local full_link = (link_start or "") .. (link_end or "")
				if #full_link > 0 then
					return full_link
				end
			end

			-- Si el título está disponible, usarlo como fallback
			if note.title and #note.title > 0 then
				return note.title
			end

			-- Último recurso (no recomendado pero necesario como backup)
			return os.date("!%Y%m%d%H%M%S")
		end,

		-- 3. MANTÉN SOLO EL AUTOCOMPLETADO Y LAS OPCIONES MÍNIMAS
		completion = {
			nvim_cmp = true,
			wiki_links = true,
		},

		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		-- El resto de opciones para deshabilitar otras funcionalidades
		daily_notes = { folder = nil },
		templates = { folder = nil },
		use_advanced_uri = false,
		open_notes_in = "current",
	},
}
