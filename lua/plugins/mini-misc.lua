return {
  "echasnovski/mini.misc",
  version = "*",
  config = function()
    require("mini.misc").setup()
    MiniMisc.setup_auto_root()
    MiniMisc.setup_restore_cursor()
    -- MiniMisc.setup_termbg_sync()

    vim.keymap.set("n", "<leader>z", MiniMisc.zoom, { desc = "Zoom buffer" })
  end,
}
