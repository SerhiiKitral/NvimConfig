return {
	"seblyng/roslyn.nvim",
	ft = "cs",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	opts = {
		-- "auto" | "roslyn" | "off"
		-- Use "roslyn" if you notice Neovim's filewatcher causing performance issues
		filewatching = "auto",

		-- Set to true if your solution lives in a parent directory of your working dir
		-- (useful for monorepos or when opening a subfolder)
		broad_search = false,

		-- Set to true to keep the same solution across buffer switches
		-- (prevents auto-switching when you have multiple .sln files)
		lock_target = false,
	},
	config = function(_, opts)
		vim.lsp.config("roslyn", {
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_indexer_parameters = true,
					dotnet_enable_inlay_hints_for_object_creation_parameters = true,
					dotnet_enable_inlay_hints_for_other_parameters = true,
					dotnet_enable_inlay_hints_for_parameters = true,
					dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				},
				["csharp|completion"] = {
					dotnet_provide_regex_completions = true,
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true,
				},
				["csharp|highlighting"] = {
					dotnet_highlight_related_json_components = true,
					dotnet_highlight_related_regex_components = true,
				},
				["navigation"] = {
					dotnet_navigate_to_decompiled_sources = true,
				},
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "openFiles",
				},
			},
		})

		require("roslyn").setup(opts)
	end,
}
