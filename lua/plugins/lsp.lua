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
      omnisharp = {},
      jsonls = {},
      lemminx = {},
    },
  },
}
