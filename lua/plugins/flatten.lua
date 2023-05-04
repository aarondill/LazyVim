return {
  "willothy/flatten.nvim",
  opts = {
    -- <String, Bool> dictionary of filetypes that should be blocking
    block_for = {
      gitcommit = true,
    },
    -- Command passthrough
    allow_cmd_passthrough = true,
    -- Allow a nested session to open if Neovim is opened without arguments
    nest_if_no_args = false,
  },
  -- Ensure that it runs first to minimize delay when opening file from terminal
  lazy = false,
  priority = 1001,
}
