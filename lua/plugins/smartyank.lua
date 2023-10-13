return {
  "ibhagwan/smartyank.nvim",
  opts = { highlight = { timeout = 1000 } },
  -- On open file
  event = { "LazyFile" },
  main = "smartyank",
  config = function(self, opts)
    -- Require main module and setup with opts
    require(self.main).setup(opts)
    -- Set clipboard to nil to stop copying to system clipboard on yank
    vim.opt.clipboard = nil
  end,
}
