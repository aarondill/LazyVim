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
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts = opts or {}
      opts.formatters = opts.formatters or {}
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = opts.linters_by_ft.markdown or {}

      table.insert(opts.linters_by_ft.markdown, "alex")
      opts.linters.alex = {
        cmd = "alex",
        args = { "--stdin", "--quiet" },
        stdin = true,
        stream = "stderr", ---@type ('stdout' | 'stderr' | 'both')
        ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
        parser = require("lint.parser").from_pattern(
          [[ *(%d+):(%d+)-(%d+):(%d+) *(%w+) *(.+) +[%w]+ +([-%l]+)]],
          { "lnum", "col", "end_lnum", "end_col", "severity", "message", "code" },
          { ["warning"] = vim.diagnostic.severity.WARN },
          { ["source"] = "alex" }
        ),
      }
    end,
  },
}
