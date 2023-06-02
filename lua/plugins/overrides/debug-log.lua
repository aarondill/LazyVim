vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = {
      debug = false,
    },
  },
}
