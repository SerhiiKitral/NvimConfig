local math_tags = {
  "MATH",
}

local math_keywords = {}
for i = 1, 50 do
  math_keywords["MATH_" .. i] = {
    icon = "",
    color = "hint",
    alt = math_tags,
  }
end

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = vim.tbl_extend("force", {}, math_keywords),
  },
}
