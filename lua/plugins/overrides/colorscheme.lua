-- Choose colorscheme differently for a tty vs a vt
---@type LazySpec
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local is_tty = require("utils.is_tty")
      local set_props = require("utils.set_props")
      local loc_opts = {}
      if is_tty() then
        loc_opts.colorscheme = "elflord"
      else
        loc_opts.colorscheme = "tokyonight"
      end
      return set_props(opts, loc_opts)
    end,
  },
}
