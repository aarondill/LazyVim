local M = {}

--- @param table table?
--- @param ... string | number
function M.deep_get(table, ...)
  if not table then
    return nil
  end
  ---@diagnostic disable-next-line: param-type-mismatch # Don't care, it works just fine with numbers too
  return vim.tbl_get(table, ...)
end

--- Return the config path (deafult path: ~/.config/nvim)
---@return string
function M.config_path()
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
function M.set_key_map(mode, lhs, rhs, desc, opts)
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

function M.bind(f, ...)
  local args = { ... }
  return function(...)
    for _, v in ipairs({ ... }) do
      table.insert(args, v)
    end
    return f(unpack(args))
  end
end

---Local implementation of M.copy_table. Not meant for outside usage.
local function copy_table(obj, seen)
  if type(obj) ~= "table" then
    return obj
  end
  if seen and seen[obj] then
    return seen[obj]
  end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do
    res[copy_table(k, s)] = copy_table(v, s)
  end
  return res
end

---Deep copies a table. Avoid doing this for performance and memory reasons.
---@param obj table a table to copy
---@return table copied_table
function M.copy_table(obj)
  return copy_table(obj)
end

---sets properties on orig with props
---@param orig table?
---@param props table
---@return table merged
function M.setProps(orig, props)
  return vim.tbl_deep_extend("force", orig or {}, props)
end

---get environemnt variables
---@param env string
---@generic T
---@param default T? the value to return of env isn't present
---@return T|string
function M.env(env, default)
  local environemnt = vim.fn.environ()
  if vim.fn.has_key(environemnt, env) then
    return environemnt[env]
  end
  return default
end

function M.is_tty()
  -- false if display is defined, else true
  return not M.env("DISPLAY")
end

---Sets vim.env.PATH with the path given added to it.
---@param path string the path to append to the vim.env.PATH
---@param append? boolean whether to append or prepend the path. false means prepend. has no effect if path is empty.
---@return string new_PATH
---@return string old_PATH
function M.extend_path(path, append)
  append = append == nil and true or append
  local r = path
  -- If empty or unset, ignore
  if vim.env.PATH and vim.env.PATH ~= "" then
    if append then
      r = vim.env.PATH .. ":" .. path
    else
      r = path .. ":" .. vim.env.PATH
    end
  end
  local old_PATH = vim.env.PATH
  local new_PATH = r
  vim.env.PATH = new_PATH
  return new_PATH, old_PATH
end

---@param plugin string the plugin name (after the slash)
---@return boolean
function M.has_plugin(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

return M
