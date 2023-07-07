local is_tty = require("utils.is_tty")
local tbl_extend = require("utils.tbl_extend")
local deep_get = require("utils.deep_get")
-- Don't change anything if not in a tty
if not is_tty() then
  return {
    -- Avoid attempting to clean for no reason
    { "uga-rosa/utf8.nvim", cond = false },
  }
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, config)
      return tbl_extend(config, {
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
    dependencies = { "uga-rosa/utf8.nvim" },
    opts = function(_, opts)
      local utf8 = require("utils.utf8")
      local group = deep_get(opts, "section", "buttons", "val")
      if not group then
        return
      end
      for _, cgroup in ipairs(group) do
        cgroup.val = utf8.sub(cgroup.val, 2)
      end
    end,
  },
}
