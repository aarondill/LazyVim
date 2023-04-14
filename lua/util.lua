local M = {}

--- @param table table?
--- @param ... string | number
M.deep_get = function(table, ...)
  if not table then
    return nil
  end
  ---@diagnostic disable-next-line: param-type-mismatch # Don't care, it works just fine with numbers too
  return vim.tbl_get(table, ...)
end

--- Return the config path (deafult path: ~/.config/nvim)
---@return string
M.config_path = function()
  ---@diagnostic disable-next-line: return-type-mismatch # Built in vim.fn.stdpath works, catppuccin messes the type up
  return vim.fn.stdpath("config")
end

-- A wrapper around |vim.keymap.set| which adds a desc arg and allows multiple lhs to be defined at the same time
---@param mode string|table    Mode short-name, see |nvim_set_keymap()|.
---@param lhs string|table     Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param desc string          Description
---@param opts table?          Table of |:map-arguments|. (If desc is defined, will be overwritten by arg)
M.set_key_map = function(mode, lhs, rhs, desc, opts)
  local descOpts = vim.tbl_extend("force", opts or {}, { desc = desc })

  assert(type(lhs) == "table" or type(lhs) == "string", "lhs must be a string or table")
  local lhsT
  if type(lhs) == "table" then
    lhsT = lhs
  else
    lhsT = { lhs }
  end

  for _, l in pairs(lhsT) do
    vim.keymap.set(mode, l, rhs, descOpts)
  end
end
return M
