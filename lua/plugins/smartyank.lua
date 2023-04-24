return {
  "ibhagwan/smartyank.nvim",
  opts = { highlight = { timeout = 1000 } },
  event = "VeryLazy",
  main = "smartyank",
  config = function(self, opts)
    -- Require main module and setup with opts
    require(self.main).setup(opts)
    -- Set clipboard to defualt to stop copying to system clipboard on yank
    vim.g.clipboard = ""
  end,
}
