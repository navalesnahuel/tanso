local function custom_hl()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f1f1f" })
end

local group = vim.api.nvim_create_augroup("custom_highlights", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	pattern = "*",
	callback = function()
		vim.schedule(custom_hl)
	end,
})
