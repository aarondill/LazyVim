---sets properties on orig with props
---@param orig table?
---@param props table
---@return table merged
return function(orig, props)
  return vim.tbl_deep_extend("force", orig or {}, props)
end
