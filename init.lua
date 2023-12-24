-- Fowards compatability:
table.pack = table.pack or function(...)
  return { n = select("#", ...), ... }
end
table.unpack = table.unpack or unpack
vim.uv = vim.uv or vim.loop

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

---This should *not* load keymaps, options, lazy, or autocmds
local function load_config()
  require("config.commands")
  -- If running in tty, set menu transparency to opaque
  if require("utils.is_tty")() then require("config.tty") end
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

--- Handle regenerating helptags in new VIMRUNTIMEs
local rt = os.getenv("VIMRUNTIME")
if rt and vim.loop.fs_access(rt, "W") then
  --- Regen the helptags
  vim.cmd.helptags(string.format("%s/doc", rt))
end
