local M = {}

--- Runs the function and inserts it's result to the
---@param str string
---@param newline? boolean
function M.insert(str, newline)
  newline = newline or false
  local row = (vim.api.nvim_win_get_cursor(0))[1]
  -- Insert a line after the cursor
  return vim.schedule(function()
    if newline then
      local lines = vim.fn.split(str, "\n", 1)
      vim.api.nvim_buf_set_lines(0, row, row, true, lines)
      local last_line = lines[#lines]
      return vim.api.nvim_win_set_cursor(0, { row + #lines, #last_line }) -- Cursor to end of text
    else
      return vim.api.nvim_put({ str }, "", true, true)
    end
  end)
end

return M
