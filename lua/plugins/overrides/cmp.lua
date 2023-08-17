return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
    local new_opts = vim.tbl_deep_extend("force", opts or {}, {
      experimental = {
        -- Don't show the ghost text (shown by tabnine)
        ghost_text = false,
      },
      mapping = {
        -- Accept without explicit selection
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      },
    })
    new_opts.sorting = new_opts.sorting or {}
    new_opts.sorting.comparators = new_opts.sorting.comparators or {}
    table.insert(new_opts.sorting.comparators, 4, function(entry1, entry2)
      local types = require("cmp.types")
      local kind1 = entry1:get_kind()
      local kind2 = entry2:get_kind()
      return kind1 == types.lsp.CompletionItemKind.Text and kind2 == types.lsp.CompletionItemKind.Snippet or nil
    end)
    for _, v in ipairs(new_opts.sources or {}) do
      v.max_item_count = nil -- Increase the max item count
    end
    return new_opts
  end,
}
