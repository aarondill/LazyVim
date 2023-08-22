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
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      ---@param utils ConditionalUtils
      local function not_is_notes(utils)
        return not utils.root_matches("^/home/.-/notes/.*$")
      end
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.alex.with({ extra_filetypes = { "markdown", "text" }, condition = not_is_notes }),
        nls.builtins.diagnostics.write_good.with({ extra_filetypes = { "markdown", "text" }, condition = not_is_notes }),
      })
    end,
  },
}
