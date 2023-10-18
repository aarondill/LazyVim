return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      if type(opts.ensure_installed) == "table" then vim.list_extend(opts.ensure_installed, { "alex" }) end
      return opts
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts = opts or {}
      opts.formatters = opts.formatters or {}
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = opts.linters_by_ft.markdown or {}
      opts.linters_by_ft.text = opts.linters_by_ft.text or {}

      table.insert(opts.linters_by_ft.markdown, "alex")
      table.insert(opts.linters_by_ft.text, "alex")
    end,
  },
}
