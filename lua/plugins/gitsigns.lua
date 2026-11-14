return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(buf)
			local gs = require("gitsigns")
			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
			end
			map("]h", function()
				gs.nav_hunk("next")
			end, "Next Hunk")
			map("[h", function()
				gs.nav_hunk("prev")
			end, "Previous Hunk")
			map("<leader>gp", gs.preview_hunk, "Preview Hunk")
			map("<leader>gr", gs.reset_hunk, "Reset Hunk")
			map("<leader>gb", gs.blame_line, "Blame Line")
		end,
	},
}
