return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = {
			enabled = true,
			notify = true,
			size = 1.5 * 1024 * 1024, -- 1.5 MB
			line_length = 1000, -- catches minified files
			setup = function(ctx)
				if vim.fn.exists(":NoMatchParen") ~= 0 then
					vim.cmd("NoMatchParen")
				end
				Snacks.util.wo(0, { foldmethod = "manual", conceallevel = 0 })
				vim.b.snacks_indent = false -- you have indent enabled; skip it here
				vim.b.completion = false -- blink.cmp respects this
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(ctx.buf) then
						vim.bo[ctx.buf].syntax = ctx.ft -- cheap regex highlighting
					end
				end)
			end,
		},
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		input = { enabled = false },
		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<C-Up>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<C-Down>"] = { "preview_scroll_down", mode = { "i", "n" } },
					},
				},
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		Snacks.toggle.inlay_hints():map("<leader>uh")
		Snacks.toggle.diagnostics():map("<leader>ud")
		Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
		Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ul")
	end,
}
