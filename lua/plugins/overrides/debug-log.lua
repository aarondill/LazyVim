vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
return {
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.WARN,
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      debug = false,
    },
  },
}
