---@type LazySpec
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
    -- Window options
    window = {
      -- Options:
      -- current        -> open in current window (default)
      -- alternate      -> open in alternate window (recommended)
      -- tab            -> open in new tab
      -- split          -> open in split
      -- vsplit         -> open in vsplit
      open = "alternate",
      -- Affects which file gets focused when opening multiple at once
      -- Options:
      -- "first"        -> open first file of new files (default)
      -- "last"         -> open last file of new files
      focus = "first",
    },
  },
  -- Ensure that it runs first to minimize delay when opening file from terminal
  lazy = false,
  priority = math.huge,
}
