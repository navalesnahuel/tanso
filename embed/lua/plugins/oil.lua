return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			view_options = {
				show_hidden = false,
			},
		})
		vim.keymap.set("n", "<leader>e", function()
			require("oil").open(vim.fn.getcwd())
		end, { desc = "Open Oil at current working directory" })
	end,
}
