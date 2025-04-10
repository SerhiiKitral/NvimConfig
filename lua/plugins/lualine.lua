return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.component_separators = { left = "|", right = "|" }
    opts.options.section_separators = { left = "", right = "" }

    opts.sections.lualine_x = vim.tbl_filter(function(component)
      if type(component) == "table" then
        if component[1] == "diff" then
          return false
        end
        if component[1] == require("lazy.status").updates then
          return false
        end
        if component.cond == require("lazy.status").has_updates then
          return false
        end
      end
      return true
    end, opts.sections.lualine_x)

    return opts
  end,
}
