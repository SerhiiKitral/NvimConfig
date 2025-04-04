-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<F8>", "<Esc>")
vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Ctrl+Backspace: delete word before cursor" })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { desc = "Ctrl+Del: delete word after cursor" })
