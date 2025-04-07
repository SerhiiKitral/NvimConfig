return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-d>"] = { "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<M-Up>"] = { "scroll_documentation_up", "fallback" },
      ["<M-Down>"] = { "scroll_documentation_down", "fallback" },
      ["<CR>"] = {},
      ["<Tab>"] = { "accept", "fallback" },
    },
    completion = {
      ghost_text = { enabled = false },
      documentation = {
        auto_show = false,
        window = {
          direction_priority = {
            menu_north = { "e", "w" },
            menu_south = { "e", "w" },
          },
        },
      },
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
    signature = {
      enabled = true,
      window = {
        min_width = 1,
        max_width = 120,
        max_height = 10,
        border = "rounded",
        winblend = 10,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,BlinkCmpSignatureHelpActiveParameter:BlinkCmpSignatureHelpActiveParameter",
        scrollbar = false,
        direction_priority = { "n", "s" },
        treesitter_highlighting = true,
        show_documentation = true,
      },
    },
  },
}
