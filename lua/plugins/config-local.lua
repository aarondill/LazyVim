---Note: This plugin can't be lazy loaded because the config can change values that need to be set early on.
---If you wish to lazy load something in the local config, then set it!

---@type LazySpec
return {
  "klen/nvim-config-local",
  main = "config-local",
  init = function(self)
    local config_local = require(self.main) ---@module "config-local"
    config_local.setup(self.opts)
    config_local.source() -- force load on startup
  end,
  config = function() end,
  lazy = false,
  opts = {
    -- Config file patterns to load (lua supported)
    config_files = { ".nvim.lua", ".nvimrc", ".exrc", ".nvim/init.lua" },
    lookup_parents = true, -- Lookup config files in parent directories
    -- silent = false, -- Disable plugin messages (Config loaded/ignored)
  },
}
