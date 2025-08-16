return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = { "BufReadPre *.md", "BufNewFile *.md" },
	dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },

	keys = {
		{ "<leader>zt", "<cmd>WikiTemplate<cr>", desc = "Wiki: Insertar plantilla" },
		{ "<leader>t", "<cmd>WikiTags<cr>", desc = "Wiki: Mostrar etiquetas" },
		{ "<leader>b", "<cmd>WikiBacklinks<cr>", desc = "Wiki: Mostrar backlinks" },
		{ "<leader>zs", "<cmd>WikiSearch<cr>", desc = "Wiki: Buscar en notas" },
		{
			"<leader>gx",
			function()
				require("obsidian").util.open_url()
			end,
			desc = "Wiki: Abrir URL externa en navegador",
		},
	},

	opts = {
		workspaces = {
			{
				name = "tanso",
				path = vim.fn.getcwd(),
			},
		},

		follow_url_func = function(url)
			vim.fn.jobstart({ "xdg-open", url }, { detach = true })
			vim.notify("Abriendo URL: " .. url, vim.log.levels.INFO)
		end,

		note_frontmatter_func = function(note)
			return {}
		end,
		note_id_func = function(note)
			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
			local link_start = line:sub(1, col):match("%[%[([^%[%]]*)$")
			local link_end = line:sub(col + 1):match("^([^%[%]]*)%]%]")
			if link_start or link_end then
				local full_link = (link_start or "") .. (link_end or "")
				if #full_link > 0 then
					return full_link
				end
			end
			if note.title and #note.title > 0 then
				return note.title
			end
			return os.date("!%Y%m%d%H%M%S")
		end,
		completion = { nvim_cmp = true, wiki_links = true },
		mappings = {
			["gD"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<cr>"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},
		daily_notes = { folder = nil },
		templates = { folder = nil },
		use_advanced_uri = false,
		open_notes_in = "current",
	},

	config = function(_, opts)
		local function open_url_cross_platform(url)
			local opener
			if vim.fn.has("macunix") == 1 then
				opener = "open"
			elseif vim.fn.has("win32") == 1 then
				opener = "explorer.exe"
			else
				opener = "xdg-open" -- El estándar para la mayoría de entornos Linux/BSD
			end
			vim.fn.jobstart({ opener, url }, { detach = true })
			vim.notify("Abriendo URL: " .. url, vim.log.levels.INFO)
		end

		opts.follow_url_func = open_url_cross_platform

		require("obsidian").setup(opts)

		vim.api.nvim_create_user_command("WikiBacklinks", "ObsidianBacklinks", {})
		vim.api.nvim_create_user_command("WikiTags", "ObsidianTags", {})
		vim.api.nvim_create_user_command("WikiTemplate", "ObsidianTemplate", {})
		vim.api.nvim_create_user_command("WikiNew", "ObsidianNew", { nargs = "?" })
		vim.api.nvim_create_user_command("WikiSearch", "ObsidianSearch", { nargs = "*" })
		vim.api.nvim_create_user_command("WikiLink", "ObsidianLink", { nargs = "*" })
		vim.api.nvim_create_user_command("WikiLinkNew", "ObsidianLinkNew", { nargs = "*" })
		vim.api.nvim_create_user_command("WikiOpenURL", function()
			require("obsidian").util.open_url()
		end, {})

		print("Configuración de notas (wiki) cargada con soporte para URLs.")
	end,
}
