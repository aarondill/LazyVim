return {
  {
    "uga-rosa/cmp-dictionary",
    lazy = true,
    init = function()
      vim.opt.dictionary:append("/usr/share/dict/words")
    end,
    opts = {
      debug = true,
      first_case_insensitive = true,
    },
    main = "cmp_dictionary",
    config = function(self, opts)
      local dict = require(self.main)
      dict.setup(opts or {})
      dict.update()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = "uga-rosa/cmp-dictionary",
    event = "VimEnter",
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      {
        name = "dictionary",
        keyword_length = 2,
      },
    }))
  end,
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
