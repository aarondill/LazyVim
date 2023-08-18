-- copied from cmp-under, but I don't think I need the plugin for this.
-- I might add some more of my own.
local function under_cmp(entry1, entry2)
  local _, entry1_under = entry1.completion_item.label:find("^_+")
  local _, entry2_under = entry2.completion_item.label:find("^_+")
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
end
local function snippets_down(entry1, entry2)
  local types = require("cmp.types")
  local kind1, kind2 = entry1:get_kind(), entry2:get_kind()
  if kind1 == kind2 then return nil end -- no preference if same
  if kind1 == types.lsp.CompletionItemKind.Snippet then return false end -- Discourage snippets
  if kind2 == types.lsp.CompletionItemKind.Snippet then return true end -- Discourage snippets
end

return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts = opts or {}
    if opts.sources then -- Increase the max item count
      for _, v in ipairs(opts.sources) do
        v.max_item_count = nil
      end
    end
    -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
    return vim.tbl_deep_extend("force", opts, {
      experimental = {
        -- Don't show the ghost text (shown by tabnine)
        ghost_text = false,
      },
      mapping = {
        -- Accept without explicit selection
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          under_cmp,
          cmp.config.compare.scopes, -- prioritize values in scope order
          snippets_down,
          cmp.config.compare.kind, -- superseded by lsp_first -- just used for lowering text
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })
  end,
}
