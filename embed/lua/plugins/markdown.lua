return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"markdown",
				"markdown_inline",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"preservim/vim-markdown",
		ft = { "markdown" },
		init = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_conceal = 2
			vim.g.vim_markdown_conceal_code_blocks = 0
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_toml_frontmatter = 1
			vim.g.vim_markdown_json_frontmatter = 1
			vim.g.vim_markdown_new_list_item_indent = 2
			vim.g.vim_markdown_auto_insert_bullets = 0
			vim.g.vim_markdown_new_list_item_indent = 0
		end,
	},
}
