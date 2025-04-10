return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              autoSearchPaths = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },
      clangd = {},
      omnisharp = {},
      jsonls = {},
      lemminx = {},
    },
  },
}
