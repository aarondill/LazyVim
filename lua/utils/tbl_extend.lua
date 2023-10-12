---merges table b into table a
---@param a table? the table to merge into.
---@param b table? the table to merge properties from.
---@return table merged a *new* table with merged properties from both tables.
return function(a, b)
  return vim.tbl_deep_extend("force", a or {}, b or {}) or {}
end
