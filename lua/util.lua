local M = {}

--- @param table table?
--- @param ... string | number
M.deep_get = function(table, ...)
  local keys = { ... }
  local t = table
  for _, p in pairs(keys) do
    if type(t) ~= "table" then
      return nil
    end
    t = (t or {})[p]
  end
  return t
end

M.config_path = function()
  return vim.fn.stdpath("config")
end
return M
