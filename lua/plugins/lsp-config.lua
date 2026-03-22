return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
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
      jsonls = {},
      lemminx = {},
      omnisharp = {
        cmd = {
          vim.fn.expand("~/.local/share/nvim/mason/packages/omnisharp/OmniSharp"),
          "--languageserver",
          "--hostPID",
          tostring(vim.fn.getpid()),
        },
        enable_editorconfig_support = true,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      },
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
