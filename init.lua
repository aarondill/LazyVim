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
local has_lazyvim_util, lazyvim_util = pcall(require, "lazyvim.util")
if has_lazyvim_util then
  lazyvim_util.on_very_lazy(load_config)
else
  load_config()
  require("config.keymaps")
  require("config.options")
  require("config.autocmds")
end
