return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
	},

	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dark_variant = "moon", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				styles = {
					italic = false,
					transparency = false,
				},

				palette = {
					moon = {
						base = "#161616",
					},
				},
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
}
