return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		if vim.fn.argc() == 0 then
			require("dashboard").setup({
				theme = "hyper",
				config = {
					-- ASCII header personalizado
					header = {
						"",
						"████████╗ █████╗ ███╗   ██╗███████╗ ██████╗ ",
						"╚══██╔══╝██╔══██╗████╗  ██║██╔════╝██╔═══██╗",
						"   ██║   ███████║██╔██╗ ██║███████╗██║   ██║",
						"   ██║   ██╔══██║██║╚██╗██║╚════██║██║   ██║",
						"   ██║   ██║  ██║██║ ╚████║███████║╚██████╔╝",
						"   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝ ",
						"",
						"                   ",
						"",
					},

					-- Sin accesos rápidos
					shortcut = {},

					-- Footer dinámico
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"",
							"GitHub: github.com/navalesnahuel/tanso",
							"Startup time: " .. ms .. "ms",
							"",
							"Exit Neovim and run `tanso vault` to set a vault and begin using the application.",
						}
					end,

					-- Elimina mru, projects, y packages
					project = { enable = false },
					mru = { enable = false },
					packages = { enable = false },
				},
			})
		end
	end,
}
