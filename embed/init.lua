require("config.lazy")
require("config.keymaps")
require("config.highlights")
require("config.options")
vim.cmd.colorscheme("rose-pine")

local api = vim.api

local top_bar_buf = nil
local top_bar_win = nil

local function render_filename()
	local filename = vim.fn.expand("%:t")
	local width = vim.o.columns
	local padding = math.floor((width - #filename) / 2)
	return string.rep(" ", padding) .. filename
end

local function create_top_bar()
	if api.nvim_win_is_valid(top_bar_win or -1) then
		api.nvim_win_close(top_bar_win, true)
	end
	top_bar_buf = api.nvim_create_buf(false, true)
	local opts = {
		style = "minimal",
		relative = "editor",
		width = vim.o.columns,
		height = 1,
		row = 0,
		col = 0,
		focusable = false,
		zindex = 100,
		noautocmd = true,
	}
	top_bar_win = api.nvim_open_win(top_bar_buf, false, opts)

	api.nvim_win_set_option(top_bar_win, "winhl", "Normal:Normal")

	api.nvim_buf_set_lines(top_bar_buf, 0, -1, false, { render_filename() })
	api.nvim_buf_set_option(top_bar_buf, "modifiable", false)
	api.nvim_buf_set_option(top_bar_buf, "readonly", true)
end

local function update_top_bar()
	if not api.nvim_buf_is_valid(top_bar_buf or -1) or not api.nvim_win_is_valid(top_bar_win or -1) then
		create_top_bar()
	else
		api.nvim_buf_set_option(top_bar_buf, "modifiable", true)
		api.nvim_buf_set_lines(top_bar_buf, 0, -1, false, { render_filename() })
		api.nvim_buf_set_option(top_bar_buf, "modifiable", false)
	end
end

api.nvim_create_autocmd("WinEnter", {
	callback = function()
		if api.nvim_get_current_win() == top_bar_win then
			local wins = api.nvim_tabpage_list_wins(0)
			for _, win in ipairs(wins) do
				if win ~= top_bar_win then
					api.nvim_set_current_win(win)
					break
				end
			end
		end
	end,
})

api.nvim_create_autocmd({
	"BufEnter",
	"BufWinEnter",
	"WinEnter",
	"VimResized",
	"InsertLeave",
}, {
	callback = function()
		vim.schedule(update_top_bar)
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		-- salteá si estás en un buffer de oil
		if vim.bo.filetype == "oil" then
			return
		end

		local mode = vim.fn.mode()
		if mode == "n" then
			vim.opt.conceallevel = 2
		else
			vim.opt.conceallevel = 0
		end
	end,
})

vim.g.vim_markdown_conceal = 2
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
