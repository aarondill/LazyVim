return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      find_files = {
        -- Note: this only applies while using find_files. Using git_files will not show these hidden files.
        -- <leader><space><space> shows git_files if possible, so .git will not be included
        hidden = true,
      },
    },
  },
}
