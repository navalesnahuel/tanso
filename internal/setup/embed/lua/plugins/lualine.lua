return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

		local custom_theme = function()
			local colors = {
				fg = "#c0c0c0",
				bg = "#1a1a1a",
				yellow = "#f1c04a",
				cyan = "#8bd5e0",
				green = "#b6e07d",
				orange = "#f78c4b",
				violet = "#df77c6",
				magenta = "#e84a5f",
				blue = "#85d3f2",
				red = "#f85c50",
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

		-- Custom component for markdown word count
		local function word_count()
			if vim.bo.filetype == "markdown" then
				local words = vim.fn.wordcount().words
				return "" .. words .. " words"
			end
			return ""
		end

		-- Custom component for markdown links count
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
						"filename",
						path = 1,
						symbols = {
							modified = "[+]",
							readonly = "[-]",
							unnamed = "",
							newfile = "",
						},
						padding = { left = 1, right = 1 },
					},
				},
				lualine_c = {},
				lualine_x = {
					{ word_count, padding = { left = 0, right = 0 } },

					{
						"location",
						padding = { left = 1, right = 0 },
					},
				},
				lualine_y = {
					{
						"progress",
						padding = { left = 1, right = 1 },
					},
				},
				lualine_z = {
					{
						"encoding",
						padding = { left = 1, right = 0 },
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
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
