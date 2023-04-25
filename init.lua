-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

---This should *not* load keymaps, options, lazy, or autocmds
local function load_config()
  require("config.commands")
  -- If running in tty, set menu transparency to opaque
  if require("utils.is_tty")() then
    require("config.tty")
  end
end
local ok, mod = pcall(require, "lazyvim.util")
if ok then
  mod.on_very_lazy(load_config)
end
