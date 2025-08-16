return {
	"folke/noice.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline",
		},

		messages = {
			enabled = true,
			view = "mini",
			view_error = "mini",
			view_warn = "mini",
		},

		popupmenu = {
			enabled = true,
		},

		notify = {
			enabled = false,
		},

		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = { enabled = true },
			signature = { enabled = false },
			message = { enabled = false },
			progress = { enabled = false },
		},

		health = {
			checker = false,
		},

		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = false,
			inc_rename = false,
			lsp_doc_border = false,
		},
	},
}
