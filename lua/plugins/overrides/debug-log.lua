vim.lsp.set_log_level(vim.lsp.log_levels.TRACE)
return { {
  "jose-elias-alvarez/null-ls.nvim",
  opts = {
    debug = true,
  },
} }
