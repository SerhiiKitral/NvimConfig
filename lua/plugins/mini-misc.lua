return {
	"nvim-mini/mini.misc",
	version = "*",
	config = function()
		require("mini.misc").setup()

		vim.keymap.set("n", "<leader>z", MiniMisc.zoom, { desc = "Zoom buffer" })
	end,
}
