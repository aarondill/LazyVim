local icons = require("config.icons")
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      indent = {
        expander_collapsed = icons["neo-tree"].default_component_configs.indent.expander_collapsed,
        expander_expanded = icons["neo-tree"].default_component_configs.indent.expander_expanded,
        indent_marker = icons["neo-tree"].default_component_configs.indent.indent_marker,
        last_indent_marker = icons["neo-tree"].default_component_configs.indent.last_indent_marker,
      },
      icon = {
        folder_closed = icons["neo-tree"].default_component_configs.icon.folder_closed,
        folder_open = icons["neo-tree"].default_component_configs.icon.folder_open,
        folder_empty = icons["neo-tree"].default_component_configs.icon.folder_empty,
        folder_empty_open = icons["neo-tree"].default_component_configs.icon.folder_empty_open,
        default = icons["neo-tree"].default_component_configs.icon.default,
      },
      git_status = {
        symbols = {
          -- Change type
          added = icons["neo-tree"].default_component_configs.git_status.symbols.added, -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = icons["neo-tree"].default_component_configs.git_status.symbols.modified, -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = icons["neo-tree"].default_component_configs.git_status.symbols.deleted, -- this can only be used in the git_status source
          renamed = icons["neo-tree"].default_component_configs.git_status.symbols.renamed, -- this can only be used in the git_status source
          -- Status type
          untracked = icons["neo-tree"].default_component_configs.git_status.symbols.untracked,
          ignored = icons["neo-tree"].default_component_configs.git_status.symbols.ignored,
          unstaged = icons["neo-tree"].default_component_configs.git_status.symbols.unstaged,
          staged = icons["neo-tree"].default_component_configs.git_status.symbols.staged,
          conflict = icons["neo-tree"].default_component_configs.git_status.symbols.conflict,
        },
      },
      modified = { symbol = icons["neo-tree"].default_component_configs.modified.symbol },
    },
    window = {
      mappings = {
        ["o"] = "open",
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
  },
}
