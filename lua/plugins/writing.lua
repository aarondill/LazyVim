return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "proselint")
      table.insert(opts.ensure_installed, "write-good")
      table.insert(opts.ensure_installed, "alex")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.proselint.with({ extra_filetypes = { "markdown", "text" } }),
        nls.builtins.code_actions.proselint.with({ extra_filetypes = { "markdown", "text" } }),
        nls.builtins.diagnostics.alex.with({ extra_filetypes = { "markdown", "text" } }),
        nls.builtins.diagnostics.write_good.with({ extra_filetypes = { "markdown", "text" } }),
      })
    end,
  },
}
