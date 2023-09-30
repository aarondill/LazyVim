return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "write-good", "alex" })
      end
      return opts
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.alex.with({ extra_filetypes = { "markdown", "text" } }),
        nls.builtins.diagnostics.write_good.with({
          extra_filetypes = { "markdown", "text" },
          extra_args = { "--no-passive", "--no-adverb" },
        }),
      })
    end,
  },
}
