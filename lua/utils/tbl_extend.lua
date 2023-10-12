local M = {}
---merges table b into table a
---@param a table? the table to merge into.
---@param b table? the table to merge properties from.
---@return table merged a *new* table with merged properties from both tables.
function M.deep_extend(a, b)
  return vim.tbl_deep_extend("force", a or {}, b or {}) or {}
end
---@param ... unknown[]
---@return unknown[]
function M.join(...)
  local ret = {}
  for _, t in ipairs({ ... }) do -- Each table provided
    for _, v in ipairs(t) do -- Each key of the tables
      table.insert(ret, v) -- Append to ret.
    end
  end
  return ret
end
return setmetatable(M, {
  __call = function(_, ...)
    return M.deep_extend(...) -- Backwards compatibility
  end,
})
