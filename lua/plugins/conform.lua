return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
			end,
			mode = { "n", "x" },
			desc = "Format Injected Langs",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			python = { "ruff_format" },
			cs = { "csharpier" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			json = { "jq" },
			xml = { "xmlformat" },
		},
		formatters = {
			csharpier = {
				command = "csharpier",
				args = { "format" },
			},
		},
	},
}
