return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 100,
			width = 105,
			height = 1,
			options = {
				number = false,
				relativenumber = false,
				signcolumn = "no",
				foldcolumn = "0",
			},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false,
				showcmd = false,
				laststatus = 3,
			},
			twilight = false,
			gitsigns = false,
			tmux = false,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				vim.cmd("ZenMode")
			end,
		})
	end,
}
