-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<F8>", "<Esc>")
vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Ctrl+Backspace: delete word before cursor" })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { desc = "Ctrl+Del: delete word after cursor" })
vim.keymap.set("n", "<M-Down>", "<Cmd>m .+1<CR>==")
vim.keymap.set("n", "<M-Up>", "<Cmd>m .-2<CR>==")
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.del("n", "<leader>dpp")
vim.keymap.del("n", "<leader>dps")
vim.keymap.del("n", "<leader>dph")

vim.keymap.set(
  "n",
  "<leader>Pp",
  "<cmd>lua require('snacks.toggle').toggle_profiler()<CR>",
  { desc = "Toggle Profiler" }
)
vim.keymap.set(
  "n",
  "<leader>Ps",
  "<cmd>lua require('snacks.toggle').toggle_profiler_summary()<CR>",
  { desc = "Profiler Summary" }
)
vim.keymap.set(
  "n",
  "<leader>Ph",
  "<cmd>lua require('snacks.toggle').toggle_profiler_highlights()<CR>",
  { desc = "Toggle Profiler Highlights" }
)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole register" })
