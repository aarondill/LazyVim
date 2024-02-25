-- Choose colorscheme differently for a tty vs a vt
---@type LazySpec
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = true, -- Enable this to disable setting the background color
      dim_inactive = true, -- dims inactive windows
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    enabled = false, -- don't even install catppuccin
  },
  -- Set to transparent (to avoid error notification)
  { "rcarriga/nvim-notify", optional = true, opts = { background_colour = "#000000" } },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local is_tty = require("utils.is_tty")
      if is_tty() then
        opts.colorscheme = function()
          local themes = { "wildcharm", "pablo" }
          for _, t in ipairs(themes) do
            local ok = pcall(vim.cmd.colorscheme, t)
            if ok then break end
          end
        end
      else
        opts.colorscheme = function() return require("tokyonight").load() end
      end
    end,
  },
}
