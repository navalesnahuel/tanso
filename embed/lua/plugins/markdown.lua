return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				-- "markdown",
				-- "markdown_inline",
			},
			highlight = {
				enable = true,
				-- additional_vim_regex_highlighting = { "markdown" },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- {
	-- 	"lukas-reineke/headlines.nvim",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	ft = { "markdown" },
	-- 	config = true,
	-- },
}
