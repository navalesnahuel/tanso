return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
					width = 0.8,
					height = 0.80,
					preview_cutoff = 120,
				},
				sorting_strategy = "ascending",
				winblend = 8,
				preview = false,
				prompt_prefix = "   ",
				selection_caret = " ",
			},
		})

		vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find file" })
		vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep in files" })
	end,
}
