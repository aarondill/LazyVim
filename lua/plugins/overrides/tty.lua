local deep_get = require("utils.deep_get")
local is_tty = require("utils.is_tty")
-- Don't change anything if not in a tty
if not is_tty() then return {} end

return {
  { "nvim-tree/nvim-web-devicons", cond = false }, -- Disable it
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      for _, v in ipairs(opts.config.center) do
        v.icon = nil -- No icons
      end
    end,
  },
}
