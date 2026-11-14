return {
	"nvim-mini/mini.icons",
	lazy = false,
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons() -- plugins that expect nvim-web-devicons use mini.icons instead
	end,
}
