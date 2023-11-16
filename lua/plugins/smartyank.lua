return {
  "ibhagwan/smartyank.nvim",
  opts = { highlight = { timeout = 1000 } },
  -- On open file
  event = { "LazyFile" },
  main = "smartyank",
  init = function()
    -- Set clipboard to '' to stop copying to system clipboard on yank
    vim.opt.clipboard = ""
  end,
  config = true,
}
