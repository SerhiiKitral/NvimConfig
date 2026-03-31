return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	opts = {
		dependencies_bin = {
			["tinymist"] = "tinymist",
		},
	},
	keys = {
		{ "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "Start Typst Preview" },
	}, -- lazy.nvim will implicitly calls `setup {}`
}
