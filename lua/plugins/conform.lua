return {
	"stevearc/conform.nvim",
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
