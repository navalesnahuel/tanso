local opt = vim.opt

-- Search settings
opt.inccommand = "split"
opt.incsearch = true
opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = false

-- Line numbers and appearance
opt.relativenumber = true
opt.termguicolors = true
opt.number = true
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true
opt.cursorlineopt = "line"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Formatting
opt.formatoptions:remove("o")
opt.guicursor = ""
opt.wrap = true
opt.linebreak = true
opt.showbreak = "↪ "
opt.breakindent = true
opt.breakindentopt = "shift:2"

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- File handling
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.updatetime = 50
opt.isfname:append("@-@")

-- Markdown specific options
opt.conceallevel = 2
opt.concealcursor = "nc"
opt.spell = true
opt.spelllang = "en_us"
opt.spelloptions = "camel"

-- Performance
opt.lazyredraw = true
opt.synmaxcol = 240
opt.redrawtime = 1500

-- UI improvements
opt.showmode = false
opt.showcmd = false
opt.ruler = false
opt.laststatus = 3
opt.cmdheight = 0
opt.showtabline = 0

-- Wild menu
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore = "*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png"

-- Folding
opt.foldmethod = "marker"
opt.foldlevelstart = 99
opt.foldnestmax = 10

-- Diff
opt.diffopt = "filler,iwhite,internal,algorithm:patience"

-- Timeout
opt.timeout = true
opt.timeoutlen = 300
opt.ttimeout = true
opt.ttimeoutlen = 10

-- Mouse
opt.mouse = "a"
opt.mousemodel = "popup"

-- List characters
opt.list = true
opt.listchars = {
	tab = "▸ ",
	trail = "·",
	extends = "❯",
	precedes = "❮",
	nbsp = "␣",
}

-- Markdown filetype specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		opt.textwidth = 80
		opt.colorcolumn = "80"
		opt.wrap = true
		opt.linebreak = true
		opt.breakindent = true
		opt.breakindentopt = "shift:2"
		opt.showbreak = "↪ "
	end,
})

-- Auto-save on focus lost
vim.api.nvim_create_autocmd("FocusLost", {
	pattern = "*",
	command = "silent! wall",
})

-- Auto-format on save for markdown
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.md",
	callback = function()
		-- Remove trailing whitespace
		vim.cmd([[%s/\s\+$//e]])
	end,
})

vim.g.vim_markdown_conceal = 2
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
