return {
  "echasnovski/mini.surround",
  opts = {
    -- Number of lines within which surrounding is searched
    n_lines = 50,

    -- Whether to respect selection type:
    -- - Place surroundings on separate lines in linewise mode.
    -- - Place surroundings on each line in blockwise mode.
    --    respect_selection_type = true,
    mappings = {
      add = "gza", -- Add surrounding in Normal and Visual modes
      delete = "gzd", -- Delete surrounding
      find = "gzf", -- Find surrounding (to the right)
      find_left = "gzF", -- Find surrounding (to the left)
      highlight = "gzh", -- Highlight surrounding
      replace = "gzr", -- Replace surrounding
      update_n_lines = "gzn", -- Update `n_lines`
    },
  },
  keys = function(_, keys)
    local chars = {
      ["("] = ")",
      ["{"] = "}",
      ["'"] = "'",
      -- Following don't work until loaded
      ['"'] = '"',
      ["["] = "]",
    }
    for k, v in pairs(chars) do
      keys[#keys + 1] = {
        k,
        ([[:<C-u>lua MiniSurround.add('visual')<CR>]] .. v),
        desc = "Surround selection with " .. v,
        mode = "x",
      }
    end
  end,
}
