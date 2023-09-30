vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
return {
  {
    "nvimtools/none-ls.nvim",
    opts = {
      debug = false,
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      debug = false,
    },
  },
}
