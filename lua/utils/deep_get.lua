--- Get a value from a table, seemlessly handling nil values
--- @param table table?
--- @param ... string | number
return function(table, ...)
  if not table then
    return nil
  end
  ---@diagnostic disable-next-line: param-type-mismatch # Don't care, it works just fine with numbers too
  return vim.tbl_get(table, ...)
end
