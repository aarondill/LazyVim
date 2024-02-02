local icons = require("config.icons")
local neoicons = icons["neo-tree"] or {}
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = vim.tbl_deep_extend("force", neoicons, {
    window = {
      mappings = {
        ["o"] = "open", -- Open on 'o'
        ["/"] = "noop", -- Don't fuzzy find on '/', use neovim's search instead
      },
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
    },
  }),
}
