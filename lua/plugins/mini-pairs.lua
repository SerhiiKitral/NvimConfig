return {
	"nvim-mini/mini.pairs",
	version = false,
	-- No need to copy this inside `setup()`. Will be used automatically.
	opts = {
		-- In which modes mappings from this `config` should be created
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
	},
}
