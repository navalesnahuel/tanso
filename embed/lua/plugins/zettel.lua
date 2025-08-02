return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = { "BufReadPre *.md", "BufNewFile *.md" },
	dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
	keys = {
		{ "<leader>zt", "<cmd>ObsidianTemplate<cr>", desc = "Insert Template" },
		{ "<leader>t", "<cmd>ObsidianTags<cr>", desc = "Show Tags" },
		{ "<leader>b", "<cmd>ObsidianBacklinks<cr>", desc = "Show Backlinks" },
	},

	opts = {
		workspaces = {
			{
				name = "tanso",
				path = vim.fn.getcwd(),
			},
		},

		note_frontmatter_func = function(note)
			return {}
		end,

		note_id_func = function(note)
			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""

			local link_start = line:sub(1, col):match("%[%[([^%[%]]*)$")
			local link_end = line:sub(col + 1):match("^([^%[%]]*)%]%]")

			if link_start or link_end then
				local full_link = (link_start or "") .. (link_end or "")
				if #full_link > 0 then
					return full_link
				end
			end

			if note.title and #note.title > 0 then
				return note.title
			end

			return os.date("!%Y%m%d%H%M%S")
		end,

		completion = {
			nvim_cmp = true,
			wiki_links = true,
		},

		mappings = {
			["gD"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		daily_notes = { folder = nil },
		templates = { folder = nil },
		use_advanced_uri = false,
		open_notes_in = "current",
		follow_url_func = nil,
	},
}
