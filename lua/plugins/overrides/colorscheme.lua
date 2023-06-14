-- Choose colorscheme differently for a tty vs a vt
---@type LazySpec
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local is_tty = require("utils.is_tty")
      local tbl_extend = require("utils.tbl_extend")
      local loc_opts = {}
      loc_opts.colorscheme = function()
        if is_tty() then
          if pcall(vim.cmd.colorscheme, "wildcharm") then
            pcall(vim.cmd.colorscheme, "pablo")
          end
        else
          require("tokyonight").load()
        end
      end
      return tbl_extend(opts, loc_opts)
    end,
  },
}
