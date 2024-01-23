---@type LazySpec
return {
  "klen/nvim-config-local",
  main = "config-local",
  cmd = { "ConfigLocalEdit", "ConfigLocalSource", "ConfigLocalTrust", "ConfigLocalIgnore" },
  event = { "VimEnter", "DirChanged", "BufWritePost", "BufRead" },
  opts = {
    -- Config file patterns to load (lua supported)
    config_files = { ".nvim.lua", ".nvimrc", ".exrc" },
    lookup_parents = true, -- Lookup config files in parent directories
    -- silent = false, -- Disable plugin messages (Config loaded/ignored)
  },
}
