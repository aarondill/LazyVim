local deep_get = require("utils.deep_get")
local is_tty = require("utils.is_tty")
-- Don't change anything if not in a tty
if not is_tty() then return end

return {
  {
    "nvim-tree/nvim-web-devicons",
    cond = false, -- Disable it
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local utf8_sanitize = require("utils.utf8-sanitize")
      local group = deep_get(opts, "section", "buttons", "val")
      if not group then return end
      for _, cgroup in ipairs(group) do
        cgroup.val = utf8_sanitize(cgroup.val, "")
      end
    end,
  },
}
