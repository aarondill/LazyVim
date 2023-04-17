-- Choose colorscheme differently for a tty vs a vt
---@type LazySpec
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local util = require("util")
      local loc_opts = {}
      if util.is_tty() then
        loc_opts.colorscheme = "elflord"
      else
        loc_opts.colorscheme = "tokyonight"
      end
      return util.setProps(opts, loc_opts)
    end,
  },
}
