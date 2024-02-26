return {
  {
    "folke/noice.nvim", -- Use noice's menu for inc_rename bc nicer than dressing's
    opts = { presets = { lsp_doc_border = true } },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
      return vim.tbl_deep_extend("force", opts or {}, {
        window = {
          completion = { -- rounded border
            border = "rounded",
          },
          documentation = { -- rounded border
            border = "rounded",
          },
        },
      })
    end,
  },
}
