vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cs", "json" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.b.snacks_indent_size = 4
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		-- Step 1: Remove \r, preserving cursor position
		local pos = vim.api.nvim_win_get_cursor(0)
		if vim.fn.search("\r", "nw") > 0 then
			vim.cmd([[%s/\r//g]])
		end
		vim.api.nvim_win_set_cursor(0, pos)

		-- Step 2: Run conform.nvim formatter (async)
		-- Note: Make sure conform.nvim is loaded and available
		local ok, conform = pcall(require, "conform")
		if ok then
			conform.format({ async = false }) -- or async = true if you prefer
		end
	end,
})

vim.api.nvim_create_autocmd("CompleteDone", {
	callback = function()
		if vim.bo.filetype == "cs" then
			vim.schedule(function()
				require("blink.cmp").show_signature()
			end)
		end
	end,
})
