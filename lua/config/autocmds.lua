vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cs", "json" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		-- vim.b.snacks_indent_size = 4
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		local buf = args.buf
		if not vim.bo[buf].modifiable then
			return
		end
		for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
			if line:find("\r", 1, true) then
				vim.api.nvim_buf_set_lines(buf, i - 1, i, false, { (line:gsub("\r", "")) })
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	callback = function()
		vim.schedule(function()
			require("lualine").refresh({ place = { "statusline" } })
		end)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function(args)
		if vim.bo[args.buf].filetype == "yazi" then
			return -- yazi uses Escape itself
		end
		vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = args.buf, desc = "Exit terminal mode" })
	end,
})
