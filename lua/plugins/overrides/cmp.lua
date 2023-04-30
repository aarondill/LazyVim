return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
    return vim.tbl_deep_extend("force", opts or {}, {
      experimental = {
        -- Don't show the ghost text (shown by tabnine)
        ghost_text = false,
      },
      mapping = {
        -- Accept without explicit selection
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      },
    })
  end,
}
