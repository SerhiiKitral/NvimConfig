return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>d", nil },
        { "<leader>P", group = "+Profiler" },
      },
    },
  },
}
