vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.cmdheight = 0

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- vim.lsp.handlers["textDocument/signatureHelp"] = function() end
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f79a70", bg = "NONE", bold = false })

vim.opt.clipboard = "unnamedplus"
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")
