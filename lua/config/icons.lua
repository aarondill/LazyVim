---@class custom_icons
--- Icons will be automatically pulled from tty if necessary
--- Icons will otherwise be gotten from gui, falling back to the tty icon if not available
--- If no icon exists, an empty string will be returned
local tty = {
  ["neo-tree"] = {
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
  },
}
---@class custom_icons
local gui = {}

---@type custom_icons
return setmetatable({}, {
  __index = function(_, key)
    local is_tty = require("utils.is_tty")
    -- If not tty, use gui. If tty or gui not exist, use tty instead
    -- Return the empty string if not exists
    return not is_tty() and gui[key] or tty[key] or ""
  end,
})
