-- ── dap-ui panel layout ─────────────────────────────────────────────────────
-- Three containers. Every panel can be toggled on its own and always comes back
-- in its container. Breakpoints are not in any container: open them as a float.
--
--   ┌─────────┬──────────────────┬─────────┐
--   │ watches │                  │         │
--   ├─────────┤       code       │ scopes  │
--   │ stacks  │                  │         │
--   ├─────────┴──────┬───────────┴─────────┤
--   │    console     │        repl         │
--   └────────────────┴─────────────────────┘
local containers = {
	{ position = "left", size = 40, elements = { "watches", "stacks" } },
	{ position = "right", size = 50, elements = { "scopes" } },
	{ position = "bottom", size = 12, elements = { "console", "repl" } },
}

-- dap-ui layouts are fixed lists of panels, so create one layout for every
-- combination of panels inside each container and open the matching one.
-- dap-ui keeps lower-numbered layouts on the outside (when opening layout N it
-- closes and reopens layouts 1..N-1 around it), so the bottom container gets
-- the lowest numbers to make it span the full width.
local build_order = { 3, 1, 2 }
local layouts, layout_index = {}, {}
for _, ci in ipairs(build_order) do
	local container = containers[ci]
	local n = #container.elements
	for mask = 1, 2 ^ n - 1 do
		local elements = {}
		for i, element in ipairs(container.elements) do
			if math.floor(mask / 2 ^ (i - 1)) % 2 == 1 then
				table.insert(elements, element)
			end
		end
		table.insert(layouts, { elements = elements, position = container.position, size = container.size })
		layout_index[ci .. ":" .. table.concat(elements, ",")] = #layouts
	end
end

local visible = { watches = true, stacks = true, scopes = true, console = true, repl = true }

-- Close everything and reopen what's visible. Left and right open first, bottom
-- last, so the bottom row always spans the full width.
local function render()
	local dapui = require("dapui")
	-- dap-ui expects Vim's default split directions; with splitright/splitbelow
	-- on, panels inside a container come out in reverse order
	local splitright, splitbelow = vim.o.splitright, vim.o.splitbelow
	vim.o.splitright, vim.o.splitbelow = false, false
	dapui.close()
	for ci, container in ipairs(containers) do
		local elements = {}
		for _, element in ipairs(container.elements) do
			if visible[element] then
				table.insert(elements, element)
			end
		end
		if #elements > 0 then
			dapui.open({ layout = layout_index[ci .. ":" .. table.concat(elements, ",")], reset = true })
		end
	end
	vim.o.splitright, vim.o.splitbelow = splitright, splitbelow
end

local function toggle(element)
	visible[element] = not visible[element]
	render()
end

local function set_all(state)
	for element in pairs(visible) do
		visible[element] = state
	end
	render()
end

-- Anything visible -> hide everything. Nothing visible -> show everything.
local function toggle_all()
	local any_visible = false
	for _, state in pairs(visible) do
		any_visible = any_visible or state
	end
	set_all(not any_visible)
end

-- ── run dap actions in the code window ─────────────────────────────────────
-- Debug keys pressed inside a dap-ui panel (REPL, console, scopes...) jump to
-- the last code window first and run there, so e.g. starting a session uses
-- your source file instead of the panel's buffer.
local last_code_win
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function()
		if vim.bo.buftype == "" and vim.api.nvim_win_get_config(0).relative == "" then
			last_code_win = vim.api.nvim_get_current_win()
		end
	end,
})

local function find_code_win()
	if last_code_win and vim.api.nvim_win_is_valid(last_code_win) then
		return last_code_win
	end
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "" and vim.api.nvim_win_get_config(win).relative == "" then
			return win
		end
	end
end

-- Wrap an action: if called from a non-file window, switch to code first.
-- Focus stays in the code window, because starting a session asks which
-- configuration to use and reads the current file only after you choose.
local function in_code(fn)
	return function()
		if vim.bo.buftype ~= "" then
			local win = find_code_win()
			if win then
				vim.api.nvim_set_current_win(win)
			end
		end
		fn()
	end
end

-- ── plugin specs ────────────────────────────────────────────────────────────
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- required by dap-ui
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
		},
		keys = {
			-- Execution
			{ "<leader>dc", in_code(function()
				require("dap").continue()
			end), desc = "Debug: Continue" },
			{ "<leader>da", in_code(function()
				require("dap").step_over()
			end), desc = "Debug: Step Over" },
			{ "<leader>di", in_code(function()
				require("dap").step_into()
			end), desc = "Debug: Step Into" },
			{ "<leader>do", in_code(function()
				require("dap").step_out()
			end), desc = "Debug: Step Out" },
			{ "<leader>dL", in_code(function()
				require("dap").run_last()
			end), desc = "Debug: Run Last" },
			{ "<leader>dt", in_code(function()
				require("dap").terminate()
			end), desc = "Debug: Terminate" },

			-- Breakpoints
			{
				"<leader>db",
				in_code(function()
					require("dap").toggle_breakpoint()
				end),
				desc = "Debug: Toggle Breakpoint",
			},
			{
				"<leader>dB",
				in_code(function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end),
				desc = "Debug: Conditional Breakpoint",
			},
			{
				"<leader>dl",
				in_code(function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log message: "))
				end),
				desc = "Debug: Log Point",
			},

			-- Panels
			{ "<leader>du", toggle_all, desc = "Debug: Toggle All Panels" },
			{
				"<leader>dw",
				function()
					toggle("watches")
				end,
				desc = "Debug: Toggle Watches",
			},
			{
				"<leader>ds",
				function()
					toggle("stacks")
				end,
				desc = "Debug: Toggle Stacks",
			},
			{
				"<leader>dv",
				function()
					toggle("scopes")
				end,
				desc = "Debug: Toggle Scopes (variables)",
			},
			{
				"<leader>dT",
				function()
					toggle("console")
				end,
				desc = "Debug: Toggle Terminal (console)",
			},
			{
				"<leader>dr",
				function()
					toggle("repl")
				end,
				desc = "Debug: Toggle REPL",
			},
			{
				"<leader>df",
				function()
					require("dapui").float_element()
				end,
				desc = "Debug: Float Panel (pick one, e.g. breakpoints)",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				mode = { "n", "v" },
				desc = "Debug: Eval",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Sign colors (tokyonight palette); re-applied if the colorscheme reloads
			local function set_dap_highlights()
				vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f7768e" })
				vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e0af68" })
				vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#7aa2f7" })
				vim.api.nvim_set_hl(0, "DapStopped", { fg = "#9ece6a" })
				vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2a3a2a" })
				vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#565f89" })
			end
			set_dap_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = set_dap_highlights })

			-- Icons (your Material Design icons, written as codes so they survive copying)
			local signs = {
				DapBreakpoint = { text = "\u{f0765}", texthl = "DapBreakpoint" }, -- md-circle
				DapBreakpointCondition = { text = "\u{f0b94}", texthl = "DapBreakpointCondition" }, -- md-eye_circle
				DapLogPoint = { text = "\u{f06ff}", texthl = "DapLogPoint" }, -- md-pencil_circle
				DapStopped = { text = "", texthl = "DapStopped", linehl = "DapStoppedLine" }, -- empty in what you sent
				DapBreakpointRejected = { text = "\u{f0159}", texthl = "DapBreakpointRejected" }, -- md-close_circle
			}
			for name, sign in pairs(signs) do
				vim.fn.sign_define(name, sign)
			end

			dapui.setup({ layouts = layouts })

			-- Every session starts with all panels open; nothing closes on exit
			dap.listeners.after.event_initialized["dapui_config"] = function()
				set_all(true)
			end

			require("nvim-dap-virtual-text").setup({ commented = true })

			-- ── C# via netcoredbg ───────────────────────────────────────────
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch (C#)",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
				{
					type = "coreclr",
					name = "Attach (C#)",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			}

			-- ── Python via debugpy ──────────────────────────────────────────
			require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "python", "coreclr" },
			automatic_installation = true,
		},
	},
}
