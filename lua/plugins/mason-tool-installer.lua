return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	opts = {
		ensure_installed = {
			-- Language servers
			"basedpyright",
			"ruff", -- also Python linting/formatting
			"lua-language-server",
			"roslyn-language-server", -- from Mason's main registry
			"tinymist",
			"clangd",
			"json-lsp",
			"lemminx",

			-- Formatters (conform.lua)
			"stylua",
			"shfmt",
			"csharpier",
			"clang-format",
			"xmlformatter", -- provides the `xmlformat` command
			"jq",

			-- Debuggers (dap.lua)
			"netcoredbg",
			"debugpy",

			-- Needed by nvim-treesitter to build parsers
			"tree-sitter-cli",
		},
		run_on_start = true,
	},
}
