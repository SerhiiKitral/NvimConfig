return {
  "saghen/blink.cmp",
  init = function()
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", {
      bold = true,
      underline = true,
      sp = "#ff5faf",
    })
  end,
}
