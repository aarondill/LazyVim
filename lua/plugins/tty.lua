local deep_get = require("utils.deep_get")
local icons = require("config.icons")
local is_tty = require("utils.is_tty")
-- Don't change anything if not in a tty
if not is_tty() then
  return {
    -- Avoid attempting to clean for no reason
    { "uga-rosa/utf8.nvim", cond = false },
  }
end

return {
  {
    "nvim-tree/nvim-web-devicons",
    cond = false, -- Disable it
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "uga-rosa/utf8.nvim" },
    opts = function(_, opts)
      local utf8 = require("utils.utf8")
      local group = deep_get(opts, "section", "buttons", "val")
      if not group then return end
      for _, cgroup in ipairs(group) do
        cgroup.val = utf8.sub(cgroup.val, 2)
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    ---@type LazyVimConfig
    opts = {
      -- icons used by other plugins
      icons = icons.lazyvim,
    },
  },
}
