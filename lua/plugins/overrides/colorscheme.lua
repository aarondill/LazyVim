-- Choose colorscheme differently for a tty vs a vt
---@type LazySpec
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local is_tty = require("utils.is_tty")
      local tbl_extend = require("utils.tbl_extend")
      local loc_opts = {}
      if is_tty() then
        loc_opts.colorscheme = "wildcharm"
      else
        loc_opts.colorscheme = "tokyonight"
      end
      return tbl_extend(opts, loc_opts)
    end,
  },
}
