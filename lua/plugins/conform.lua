return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "black" },
      cs = { "csharpier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
  },
}
