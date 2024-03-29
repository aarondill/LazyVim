require("future") -- Fowards compatability

-- This needs to come first!
require("config.lazy") -- bootstrap lazy.nvim, LazyVim and your plugins

-- Require all the files in ./config
require("lazy.core.util").lsmod("config", require)

--- Handle regenerating helptags in new VIMRUNTIMEs
local rt = os.getenv("VIMRUNTIME")
if rt and vim.loop.fs_access(rt, "W") then
  --- Regen the helptags
  vim.cmd.helptags(vim.fs.joinpath(rt, "doc"))
end
