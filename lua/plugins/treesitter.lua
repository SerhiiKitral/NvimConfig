return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "bash",
        "json",
        "markdown",
        "typst",
        "rust",
        "c_sharp",
        "python",
      },
      highlight = { enable = true },
    },
  },
}
