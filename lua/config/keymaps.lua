local map = vim.keymap.set

vim.keymap.set({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)

map("n", "<leader>nn", "<cmd>noh<cr>", { desc = "Clear Search Highlight" })
map("i", "<C-H>", "<C-w>", { desc = "Ctrl+Backspace: delete word before cursor" })
map("i", "<C-Del>", "<C-o>dw", { desc = "Ctrl+Del: delete word after cursor" })

map({ "x" }, "<leader>p", "P", { desc = "Paste without overwriting register" })

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using <ctrl> arrows
map("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window" })

-- Resize window using <ctrl-shift> arrows
map("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- buffers
map("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>:bd!<cr>", { desc = "Delete Buffer and Window" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map("n", "<leader>s", "<cmd>w<cr>", { desc = "Save File" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- location list
map("n", "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

map("n", "<leader>qq", "<cmd>qa!<cr>", { desc = "Quit All" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<C-M-Left>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<C-M-Right>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

--
map("n", "<leader>nh", "<cmd>messages<cr>", { desc = "Messages History" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = args.buf,
				desc = desc,
				nowait = lhs == "gr",
			})
		end

		-- Navigation
		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "gr", vim.lsp.buf.references, "Find references")
		map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")

		-- Docs
		map("n", "K", vim.lsp.buf.hover, "Hover docs")
		map("n", "gK", vim.lsp.buf.signature_help, "Signature help")

		-- Refactor
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

		-- Formatting
		map("n", "<leader>cf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, "Format file")

		-- Diagnostics
		map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
	end,
})

-- Find
-- stylua: ignore start
map("n", "<leader><space>", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep Project" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent Files" })

-- LSP
map("n", "<leader>cw", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace Symbols" })
-- map("n", "<leader>cs", function() Snacks.picker.lsp_symbols() end, { desc = "Document Symbols" })  -- replaces your trouble one if you prefer

-- Git
map("n", "<leader>gc", function() Snacks.picker.git_log() end, { desc = "Git Commits" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })

-- Snacks
map("n", "<leader>ns", function() Snacks.notifier.show_history() end, { desc = "Notification History" })

map("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
map("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

map("n", "<leader>p", "<cmd>put<cr>", { desc = "Paste on new line below" })
map("n", "<leader>P", "<cmd>put!<cr>", { desc = "Paste on new line above" })
