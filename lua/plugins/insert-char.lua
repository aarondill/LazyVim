return {
  "rjayatilleka/vim-insert-char",
  init = function()
    -- Disable default (space)
    vim.g.insert_char_no_default_mapping = 1
  end,
  keys = {
    {
      -- set <C-i><key> as insert one char.
      -- Repeatable with <count><C-i><key>
      -- Works with period
      "<C-i>",
      "<Plug>InsertChar",
      mode = { "n" },
    },
  },
}
