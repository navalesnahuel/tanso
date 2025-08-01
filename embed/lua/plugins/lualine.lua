return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

		local custom_theme = function()
			local colors = {
				fg = "#c0c0c0", -- más claro
				yellow = "#f1c04a", -- más vibrante
				cyan = "#8bd5e0", -- más claro y saturado
				green = "#b6e07d", -- más brillante
				orange = "#f78c4b", -- más contrastado
				violet = "#df77c6", -- más saturado y brillante
				magenta = "#e84a5f", -- rojo magenta más fuerte
				blue = "#85d3f2", -- azul cielo más saturado
				red = "#f85c50", -- rojo más llamativo
			}

			return {
				normal = {
					a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
					b = { fg = colors.fg, bg = colors.bg },
					c = { fg = colors.fg, bg = colors.bg },
				},
				insert = {
					a = { fg = colors.blue, bg = colors.bg, gui = "bold" },
					b = { fg = colors.fg, bg = colors.bg },
					c = { fg = colors.fg, bg = colors.bg },
				},
				visual = {
					a = { fg = colors.yellow, bg = colors.bg, gui = "bold" },
					b = { fg = colors.fg, bg = colors.bg },
					c = { fg = colors.fg, bg = colors.bg },
				},
				replace = {
					a = { fg = colors.red, bg = colors.bg, gui = "bold" },
					b = { fg = colors.fg, bg = colors.bg },
					c = { fg = colors.fg, bg = colors.bg },
				},
				command = {
					a = { fg = colors.green, bg = colors.bg, gui = "bold" },
					b = { fg = colors.fg, bg = colors.bg },
					c = { fg = colors.fg, bg = colors.bg },
				},
				inactive = {
					a = { fg = colors.fg, bg = colors.bg },
					b = { fg = colors.fg, bg = colors.bg },
					c = { fg = colors.fg, bg = colors.bg },
				},
			}
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = custom_theme(),
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
				},
				always_divide_middle = true,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { { "mode", padding = { left = 1, right = 0 } } },
				lualine_b = {
					{
						-- "filename",
						-- path = 0,
						-- shorting_target = 40,
						-- symbols = {
						-- 	modified = "[+]",
						-- 	readonly = "[-]",
						-- 	unnamed = "No Name",
						-- 	newfile = "New",
						-- 	padding = { left = 1, right = 1 },
						-- },
					},
				},

				lualine_x = {
					-- { "branch", icon = "", padding = { left = 1, right = 1 } },
					-- {
					-- 	"diff",
					-- 	symbols = { added = "+", modified = "~", removed = "-" },
					-- 	padding = { left = 1, right = 1 },
					-- },
				},
				lualine_c = {
					-- { "diagnostics", padding = { left = 1, right = 1 } }
				},
				lualine_y = {
					-- { "filetype", padding = 0 }
				},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_c = { "filename" },
			},
			tabline = {},
			winbar = {},
			extensions = { "lazy" },
		})

		vim.cmd([[
			hi StatusLine ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
			hi StatusLineNC ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
		]])

		vim.opt.cmdheight = 0
	end,
}
