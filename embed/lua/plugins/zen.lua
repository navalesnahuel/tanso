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
		on_open = function()
			vim.g.zen_mode_active = true
		end,
		on_close = function()
			vim.g.zen_mode_active = false
			-- Reactivar inmediatamente si algo intenta cerrarlo
			vim.schedule(function()
				require("zen-mode").open()
			end)
		end,
	},
	init = function()
		-- Forzar ZenMode al iniciar la UI
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				require("zen-mode").open()
			end,
		})

		-- Reactivar al cambiar buffer, ventana o modo
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
			callback = function()
				vim.defer_fn(function()
					if not vim.g.zen_mode_active then
						require("zen-mode").open()
					end
				end, 10)
			end,
		})

		-- (Opcional) Bloquear el comando :ZenMode para evitar desactivarlo manualmente
		vim.api.nvim_create_user_command("ZenMode", function() end, {})
	end,
}
