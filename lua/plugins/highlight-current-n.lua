return {
  "rktjmp/highlight-current-n.nvim",
  opts = { highlight_group = "IncSearch" },
  init = function()
    vim.opt.hlsearch = false
    -- Some QOL autocommands
    local ClearSearchHL = vim.api.nvim_create_augroup("ClearSearchHL", { clear = true })
    -- You may only want to see hlsearch /while/ searching, you can automatically
    -- toggle hlsearch with the following autocommands
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      pattern = { "/", "\\?" },
      callback = function()
        vim.opt.hlsearch = true
      end,
      group = ClearSearchHL,
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
      pattern = { "/", "\\?" },
      callback = function()
        vim.opt.hlsearch = false
      end,
      group = ClearSearchHL,
    })
    -- this will apply similar n|N highlighting to the first search result
    -- careful with escaping ? in lua, you may need \\?
    vim.api.nvim_create_autocmd("CmdlineLeave", {
      pattern = { "/", "\\?" },
      callback = function()
        require("highlight_current_n")["/,?"]()
      end,
      group = ClearSearchHL,
    })
  end,
  keys = {
    {
      "n",
      function()
        require("highlight_current_n").n()
      end,
      mode = "n",
    },
    {
      "N",
      function()
        require("highlight_current_n").N()
      end,
      mode = "n",
    },
  },
  -- config = function(_, opts)
  --   local hcn = require("highlight_current_n")
  -- end,
}
