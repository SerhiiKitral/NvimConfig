return {
	"nvim-mini/mini.pairs",
	opts = {
		modes = { insert = true, command = false, terminal = false },

		mappings = {
			["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
			["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
			["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },

			[")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },
			["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },
			["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

			['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^\\]", register = { cr = false } },
			["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%a\\]", register = { cr = false } },
			["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\]", register = { cr = false } },
		},
		skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
		-- skip autopair when next character is closing pair
		-- and there are more closing pairs than opening pairs
		skip_unbalanced = true,
		-- better deal with markdown code blocks
		markdown = true,
	},
}
