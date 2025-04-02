return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-d>"] = { "show_documentation", "hide_documentation" },
      ["<C-Up>"] = { "select_prev", "fallback" },
      ["<C-Down>"] = { "select_next", "fallback" },
      ["<M-Up>"] = { "scroll_documentation_up", "fallback" },
      ["<M-Down>"] = { "scroll_documentation_down", "fallback" },
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<CR>"] = {},
      ["<Tab>"] = { "accept", "fallback" },
    },
    completion = {
      ghost_text = { enabled = false },
      documentation = { auto_show = false },
      list = {
        selection = { preselect = true, auto_insert = false },
      },
      menu = {
        draw = {
          columns = {
            { "label" },
            { "kind" },
          },
        },
      },
    },
  },
}
