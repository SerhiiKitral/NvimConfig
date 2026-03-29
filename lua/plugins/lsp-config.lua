return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	opts = {
		servers = {
			pyright = {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							extraPaths = { "./" },
						},
					},
				},
			},
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
		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end,
}
