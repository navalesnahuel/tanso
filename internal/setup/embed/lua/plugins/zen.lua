return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 100,
			width = 100,
			height = 0.9,
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
		on_open = function()
			vim.g.zen_mode_active = true
		end,
		on_close = function()
			vim.g.zen_mode_active = false
			vim.schedule(function()
				require("zen-mode").open()
			end)
		end,
	},
	init = function()
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				require("zen-mode").open()
			end,
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
			callback = function()
				vim.defer_fn(function()
					if not vim.g.zen_mode_active then
						require("zen-mode").open()
					end
				end, 10)
			end,
		})

		vim.api.nvim_create_user_command("ZenMode", function() end, {})
	end,
}
