local term_buf = nil
local term_win = nil

vim.keymap.set("n", "<leader>ft", function()
  -- if buffer doesn't exist or was deleted, create fresh
  if term_buf == nil or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
    local height = math.floor(vim.o.lines * 0.3)

    term_win = vim.api.nvim_open_win(term_buf, true, {
      split = "below",
      height = height,
    })

    vim.cmd("terminal")
    vim.cmd("startinsert")

    vim.api.nvim_create_autocmd("TermClose", {
      buffer = term_buf,
      once = true,
      callback = function()
        vim.schedule(function()
          if term_buf ~= nil and vim.api.nvim_buf_is_valid(term_buf) then
            vim.api.nvim_buf_delete(term_buf, { force = true })
          end
          term_buf = nil
          term_win = nil
        end)
      end,
    })

    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = term_buf })
    return
  end

  -- if window is visible - hide it
  if term_win ~= nil and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_hide(term_win)
    term_win = nil
    return
  end

  -- buffer exists but not visible - reopen it
  local height = math.floor(vim.o.lines * 0.3)
  term_win = vim.api.nvim_open_win(term_buf, true, {
    split = "below",
    height = height,
  })
  vim.cmd("startinsert")
end, { desc = "Toggle Terminal" })
