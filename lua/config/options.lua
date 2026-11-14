vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.cmdheight = 0

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.cursorline = true

vim.opt.clipboard = "unnamedplus"

vim.opt.foldtext = ""
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.undofile = true
vim.opt.ignorecase = true -- search ignores case...
vim.opt.smartcase = true -- ...unless you type a capital letter

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = {
		current_line = true,
		format = function(diagnostic)
			-- space left to the right of the error column (minus gutter and connector)
			local width = math.max(vim.api.nvim_win_get_width(0) - diagnostic.col - 16, 30)
			local out = {}
			local text = diagnostic.code and (diagnostic.code .. ": " .. diagnostic.message) or diagnostic.message
			for _, line in ipairs(vim.split(text, "\n")) do
				local current = ""
				for word in line:gmatch("%S+") do
					if current ~= "" and #current + #word + 1 > width then
						table.insert(out, current)
						current = "  " .. word
					else
						current = current == "" and word or current .. " " .. word
					end
				end
				table.insert(out, current)
			end
			return table.concat(out, "\n")
		end,
	},
	severity_sort = true,
	float = { border = "rounded" },
})
