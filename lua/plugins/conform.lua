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
			python = { "black" },
			cs = { "csharpier" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			json = { "prettier" },
		},
		formatters = {
			prettier = {
				prepend_args = {
					"--parser",
					"json",
					"--tab-width",
					"2",
					"--use-tabs",
					"false",
					"--print-width",
					"80",
					"--bracket-same-line",
					"false",
				},
			},
			csharpier = {
				command = "csharpier",
				args = { "format" },
			},
		},
	},
}
