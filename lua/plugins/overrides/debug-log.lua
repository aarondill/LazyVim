vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
return {
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.lsp.log_levels.OFF,
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      debug = false,
    },
  },
}
