return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    -- Error handling
    opts = opts or {}
    opts.experimental = opts.experimental or {}
    opts.mapping = opts.mapping or {}

    -- Modifications
    opts.experimental.ghost_text = false
    -- Accept without explicit selection
    opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })
  end,
}
