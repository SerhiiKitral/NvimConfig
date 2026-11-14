return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	opts = {
		servers = {
			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							extraPaths = { "./" },
						},
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
						},
					},
				},
			},
			ruff = {},
			tinymist = {
				settings = {
					exportPdf = "never",
					outputPath = "$root/target/$dir/$name",
					formatterMode = "typstyle",
				},
			},
			clangd = {},
			jsonls = {},
			lemminx = {},
		},
	},
	config = function(_, opts)
		vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
		for server, config in pairs(opts.servers) do
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end,
}
