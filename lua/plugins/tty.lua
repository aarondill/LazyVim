local util = require("util")
-- Don't change anything if not in a tty
if not util.is_tty() then
  return {}
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, config)
      return util.setProps(config, {
        default_component_configs = {
          indent = {
            expander_collapsed = "▶",
            expander_expanded = "▼",
          },
          icon = {
            folder_closed = "📁",
            folder_open = "📂",
            folder_empty = "📂",
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
}
