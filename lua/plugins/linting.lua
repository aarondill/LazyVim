return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("keep", opts or {}, {
        ensure_installed = {},
      })
      return vim.list_extend(opts.ensure_installed, {
        "alex",
        "gitlint",
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      --- Set up the table. Don't overwrite any existing values!
      opts = vim.tbl_deep_extend("keep", opts or {}, {
        linters = {},
        linters_by_ft = {
          markdown = {},
          text = {},
          gitcommit = {},
        },
      })

      vim.list_extend(opts.linters_by_ft.markdown, { "alex" })
      vim.list_extend(opts.linters_by_ft.text, { "alex" })
      vim.list_extend(opts.linters_by_ft.gitcommit, { "gitlint" })
      return opts
    end,
  },
}
