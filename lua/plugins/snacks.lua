return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = false },
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
