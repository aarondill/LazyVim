return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
