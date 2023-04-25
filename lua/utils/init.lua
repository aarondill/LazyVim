local M = {}

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
