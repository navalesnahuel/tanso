return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				-- Minimalist layout
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						width = 0.8,
						height = 0.8,
						preview_height = 0.6,
						preview_cutoff = 120,
						mirror = false,
					},
				},
				-- Minimal borders
				border = false,
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				-- Search bar at the top
				prompt_prefix = " ",
				selection_caret = " ",
				entry_prefix = " ",
				-- Minimal colors
				color_devicons = false,
				-- Clean results
				path_display = { "truncate" },
				file_ignore_patterns = {
					"node_modules",
					".git",
					"*.pyc",
					"__pycache__",
					".DS_Store",
				},
				-- Minimal actions
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
					n = {
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = false,
					no_ignore_parent = false,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
		})
	end,
	keys = {
		{
			"<leader>/",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep (Telescope)",
		},
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files({ hidden = true })
			end,
			desc = "Find Files (Telescope)",
		},
		{
			"<leader>fw",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Grep word/selection (Telescope)",
			mode = { "n", "x" },
		},
	},
}
