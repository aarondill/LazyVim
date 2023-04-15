return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local util = require("util")
    local cmp = require("cmp")
    -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
    return util.setProps(opts, {
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
