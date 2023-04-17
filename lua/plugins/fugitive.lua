---@type LazySpec
return {
  "tpope/vim-fugitive",
  dependancies = { "aymericbeaumet/vim-symlink", dependancies = { "moll/vim-bbye" } },
  event = "VeryLazy",
}
