-- Fowards compatability:
table.pack = table.pack or function(...)
  return { n = select("#", ...), ... }
end
table.unpack = table.unpack or unpack
vim.uv = vim.uv or vim.loop

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- If running in tty, set menu transparency to opaque
if require("utils.is_tty")() then require("config.tty") end
require("config.commands")
require("config.keymaps")
require("config.options")
require("config.autocmds")

--- Handle regenerating helptags in new VIMRUNTIMEs
local rt = os.getenv("VIMRUNTIME")
if rt and vim.loop.fs_access(rt, "W") then
  --- Regen the helptags
  vim.cmd.helptags(vim.fs.joinpath(rt, "doc"))
end
