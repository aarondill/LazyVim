---@type LazySpec
return {
  "klen/nvim-config-local",
  main = "config-local",
  lazy = false,
  opts = {
    -- Config file patterns to load (lua supported)
    config_files = { ".nvim.lua", ".nvimrc", ".exrc", ".nvim/init.lua" },
    lookup_parents = true, -- Lookup config files in parent directories
    -- silent = false, -- Disable plugin messages (Config loaded/ignored)
  },
}
