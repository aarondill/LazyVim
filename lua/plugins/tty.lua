local util = require("utils")
local set_props = require("utils.set_props")
local deep_get = require("utils.deep_get")
-- Don't change anything if not in a tty
if not util.is_tty() then
  return {}
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, config)
      return set_props(config, {
        default_component_configs = {
          indent = {
            expander_collapsed = "▶",
            expander_expanded = "▼",
          },
          icon = {
            folder_closed = "-",
            folder_open = "+",
            folder_empty = "_",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "x", -- this can only be used in the git_status source
              renamed = "->", -- this can only be used in the git_status source
              -- Status type
              untracked = "?",
              ignored = "/",
              unstaged = "_",
              staged = "+",
              conflict = "!",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    enabled = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local symbols = deep_get(opts, "sections", "lualine_c", 3, "symbols")
      if symbols then
        symbols.modified = " + "
      else
        print("Check your lualine configuration! It's in a different order than predefined")
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "|" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = ":" },
        untracked = { text = "?" },
      },
    },
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local group = deep_get(opts, "section", "buttons", "val")
      if not group then return end

      local icons = { "", "", "", "", "" }
      for i, v in ipairs(icons) do
        if not group[i] then goto continue end
        ---@type {val: string}
        local curr_val = group[i]
        curr_val.val = v..curr_val.val:sub(1)
        ::continue::
      end
    end,
  },
}
