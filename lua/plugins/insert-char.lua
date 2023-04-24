return {
  "rjayatilleka/vim-insert-char",
  init = function()
    -- Disable default (space)
    vim.g.insert_char_no_default_mapping = 1
  end,
  keys = {
    {
      -- set \<key> as insert one char.
      -- Repeatable with <count>\<key>
      -- Works with period
      "\\",
      "<Plug>InsertChar",
      mode = { "n" },
    },
  },
}
