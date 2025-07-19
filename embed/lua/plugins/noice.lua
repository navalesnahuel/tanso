return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		lsp = {
			progress = { enabled = false },
			signature = { enabled = false },
			hover = { enabled = false },
			message = { enabled = false },
		},
		messages = {
			enabled = true,
			view = "mini", -- pequeño mensaje inline
			view_error = "mini", -- errores discretos
			view_warn = "mini",
			view_history = "messages",
		},
		cmdline = {
			enabled = true,
			view = "cmdline", -- reemplazo simple, abajo
			format = {
				search_down = { icon = "", conceal = false },
				search_up = { icon = "", conceal = false },
			},
		},
		popupmenu = {
			enabled = false, -- no mostrar popup visual (más minimal)
		},
		presets = {
			bottom_search = true, -- búsqueda abajo, como siempre
			command_palette = false,
			long_message_to_split = false, -- nunca abrir mensajes largos en ventana aparte
			inc_rename = false,
			lsp_doc_border = false,
		},
		views = {
			mini = {
				win_options = {
					winblend = 20,
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
		},
	},
}
