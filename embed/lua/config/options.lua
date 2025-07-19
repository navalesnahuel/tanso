local opt = vim.opt

-- You have to turn this one on :)
opt.inccommand = "split"
opt.incsearch = true

-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = false

opt.relativenumber = true
opt.termguicolors = true
opt.number = true
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true

opt.clipboard = "unnamedplus"

-- Don't have `o` add a comment
opt.formatoptions:remove("o")
opt.guicursor = ""
-- opt.wrap = false

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.scrolloff = 8

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.updatetime = 50
opt.isfname:append("@-@")
