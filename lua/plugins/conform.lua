return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
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
	},
}
