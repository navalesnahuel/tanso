-- Load Tanso configuration
require("config.lazy")
require("config.highlights")
require("config.options")

-- Set colorscheme
vim.cmd.colorscheme("rose-pine")

-- Tanso-specific autocmds
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "oil" then
			return
		end
		vim.opt.conceallevel = (vim.fn.mode() == "n") and 2 or 0
	end,
})

-- Markdown-specific settings
vim.g.vim_markdown_conceal = 2
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
