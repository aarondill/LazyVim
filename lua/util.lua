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
---@param mode string|string[] Mode short-name, see |nvim_set_keymap()|.
---@param lhs string|string[]  Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param desc string?         Description or opts
---@param opts table?          Table of |:map-arguments|. (If desc is defined, will be overwritten by arg)
---@overload fun(mode:string|string[], lhs:string|string[], rhs:string|function, opts:table)
M.set_key_map = function(mode, lhs, rhs, desc, opts)
  local descOpts
  if type(desc) == "string" then
    descOpts = vim.tbl_extend("force", opts or {}, { desc = desc })
  else
    assert((desc == nil or type(desc) == "table") and opts == nil, "Desc can only be a table if opts is nil")
    descOpts = desc
  end

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

M.bind = function(f, ...)
  local args = { ... }
  return function(...)
    for _, v in ipairs({ ... }) do
      table.insert(args, v)
    end
    return f(unpack(args))
  end
end

---sets properties on orig with props
---@param orig table?
---@param props table
---@return table merged
M.setProps = function(orig, props)
  return vim.tbl_deep_extend("force", orig or {}, props)
end

---get environemnt variables
---@param env string
---@generic T
---@param default T? the value to return of env isn't present
---@return T|string
M.env = function(env, default)
  local environemnt = vim.fn.environ()
  if vim.fn.has_key(environemnt, env) then
    return environemnt[env]
  end
  return default
end

M.is_tty = function()
  -- false if display is defined, else true
  return not M.env("DISPLAY")
end

return M
