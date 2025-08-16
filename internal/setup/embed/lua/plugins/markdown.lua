return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- Opción 1: Suite completa
		---@type render.md.UserConfig
		opts = {
			file_types = { "markdown" },
			ft = { "markdown" },
			render_modes = true,
			completions = { lsp = { enabled = true } },
			heading = {
				enabled = true,
				render_modes = false,
				atx = true,
				setext = true,
				sign = true,
				icons = { "", "", "", "", "", "" },
				position = "overlay",
				signs = { "" },
				width = "full",
				left_margin = 0,
				left_pad = 0,
				right_pad = 0,
				min_width = 0,
				border = false,
				border_virtual = false,
				border_prefix = false,
				above = "▄",
				below = "▀",
				custom = {},
			},
			quote = { repeat_linebreak = true },
			link = {
				enabled = true,
				render_modes = false,
				footnote = {
					enabled = true,
					superscript = true,
					prefix = "",
					suffix = "",
				},
				image = "󰥶 ",
				email = "󰀓 ",
				hyperlink = "󰌹 ",
				highlight = "RenderMarkdownLink",
				wiki = {
					icon = "",
					body = function()
						return nil
					end,
					highlight = "RenderMarkdownWikiLink",
				},
				custom = {
					web = { pattern = "^http", icon = "󰖟 " },
					discord = { pattern = "discord%.com", icon = "󰙯 " },
					github = { pattern = "github%.com", icon = "󰊤 " },
					gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
					google = { pattern = "google%.com", icon = "󰊭 " },
					neovim = { pattern = "neovim%.io", icon = " " },
					reddit = { pattern = "reddit%.com", icon = "󰑍 " },
					stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
					wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
					youtube = { pattern = "youtube%.com", icon = "󰗃 " },
				},
			},
			bullet = {
				enabled = true,
				render_modes = false,
				icons = { "●", "○", "•", "◦" },
				ordered_icons = function(ctx)
					local value = vim.trim(ctx.value)
					local index = tonumber(value:sub(1, #value - 1))
					return ("%d."):format(index > 1 and index or ctx.index)
				end,
				left_pad = 0,
				right_pad = 1,
				highlight = "RenderMarkdownBullet",
				scope_highlight = {},
			},
			checkbox = {
				enabled = true,
				render_modes = false,
				bullet = false,
				right_pad = 1,
				unchecked = {
					-- Replaces '[ ]' of 'task_list_marker_unchecked'.
					icon = "󰄱 ",
					highlight = "RenderMarkdownUnchecked",
					scope_highlight = nil,
				},
				checked = {
					-- Replaces '[x]' of 'task_list_marker_checked'.
					icon = "󰱒 ",
					highlight = "RenderMarkdownChecked",
					scope_highlight = nil,
				},
			},
		},
	},
}
