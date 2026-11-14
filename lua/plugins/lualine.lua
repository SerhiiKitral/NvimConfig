return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_x = {
				{
					function()
						return "recording @" .. vim.fn.reg_recording()
					end,
					cond = function()
						return vim.fn.reg_recording() ~= ""
					end,
					color = { fg = "#ff9e64" },
				},
				"encoding",
				"fileformat",
				"filetype",
			},
		},
	},
}
