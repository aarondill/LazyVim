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
local has_lazyvim_util, lazyvim = pcall(require, "lazyvim.util")
-- stylua: ignore
if has_lazyvim_util then
  lazyvim.on_very_lazy(load_config)
else
  load_config()
end

if not has_lazyvim_util then -- Do now
  require("config.keymaps")
  require("config.options")
  require("config.autocmds")
end
