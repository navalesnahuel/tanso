return {
	{ "echasnovski/mini.surround", version = false, config = true },
	{ "echasnovski/mini.comment", version = false, config = true },
	{
		"echasnovski/mini.statusline",
		version = false,
		config = function()
			local statusline = require("mini.statusline")

			statusline.setup({
				use_icons = false,
				set_vim_settings = false,
			})

			-- Renombrar los modos
			local mode_map = {
				["n"] = "PREVIEW",
				["i"] = "EDITION",
				["v"] = "VISUAL",
				["V"] = "V-LINE",
				[""] = "V-BLOCK",
				["c"] = "COMMAND",
				["R"] = "REPLACE",
				["s"] = "SELECT",
				["S"] = "S-LINE",
				[""] = "S-BLOCK",
				["t"] = "TERMINAL",
			}

			statusline.section_mode = function()
				local mode_code = vim.fn.mode()
				return mode_map[mode_code] or mode_code
			end

			-- Ocultar las secciones innecesarias
			statusline.section_git = function()
				return ""
			end
			statusline.section_diagnostics = function()
				return ""
			end
			statusline.section_filename = function()
				return ""
			end
			statusline.section_fileinfo = function()
				return ""
			end

			-- Sección de ubicación del cursor
			statusline.section_location = function()
				local line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local col = vim.fn.virtcol(".")
				local percent = math.floor((line / total_lines) * 100)
				return string.format("%d|%d %d|%d%%", line, total_lines, col, percent)
			end
		end,
	},
}
