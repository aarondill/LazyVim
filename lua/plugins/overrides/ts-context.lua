-- Show context of the current function
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  optional = true,
  event = "LazyFile",
  enabled = true,
  cmd = {
    "TSContextEnable",
    "TSContextDisable",
    "TSContextToggle",
  },
  ---@type LazyKeysSpec[]
  keys = {
    {
      "<leader>ut",
      function() -- lazy require!
        local ctx = require("treesitter-context")
        ctx.toggle()
        local action = ctx.enabled() and "Enabled" or "Disabled"
        vim.notify(action .. " context")
      end,
      desc = "Toggle context",
    },
  },
  ---@type TSContext.UserConfig
  opts = {
    enable = false,
    mode = "cursor",
    max_lines = 5,
    min_window_height = 10,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = "outer",
    separator = nil,
    zindex = 20,
    on_attach = nil,
  },
}
