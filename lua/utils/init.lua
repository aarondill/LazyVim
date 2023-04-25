local M = {}

---@param plugin string the plugin name (after the slash)
---@return boolean
function M.has_plugin(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

return M
