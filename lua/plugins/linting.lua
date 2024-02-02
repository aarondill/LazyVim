return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "alex")
      table.insert(opts.ensure_installed, "gitlint")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      --- Set up the table. Don't overwrite any existing values!
      opts = vim.tbl_deep_extend("keep", opts or {}, {
        linters = {},
        linters_by_ft = { markdown = {}, text = {}, gitcommit = {} },
      })
      table.insert(opts.linters_by_ft.markdown, "alex")
      table.insert(opts.linters_by_ft.text, "alex")
      table.insert(opts.linters_by_ft.gitcommit, "gitlint")
      return opts
    end,
  },
}
