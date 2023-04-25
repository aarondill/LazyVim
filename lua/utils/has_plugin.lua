---Returns a boolean indicating whether a package is present (through lazy)
---@param plugin string the plugin name (after the slash)
---@return boolean
return function(plugin)
  local ok, mod = pcall(require, "lazy.core.config")
  local levels = vim.log.levels
  if ok then
    return mod.plugins[plugin] ~= nil
  else
    vim.notify(
      ("Something went wrong checking if plugin %s is available through lazy.nvim."):format(plugin),
      levels.ERROR
    )
    return false
  end
end
