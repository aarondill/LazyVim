return {
  "echasnovski/mini.surround",
  opts = {
    -- Number of lines within which surrounding is searched
    n_lines = 50,

    -- Whether to respect selection type:
    -- - Place surroundings on separate lines in linewise mode.
    -- - Place surroundings on each line in blockwise mode.
    respect_selection_type = true,
    mappings = {
      add = "gca", -- Add surrounding in Normal and Visual modes
      delete = "gcd", -- Delete surrounding
      find = "gcf", -- Find surrounding (to the right)
      find_left = "gcF", -- Find surrounding (to the left)
      highlight = "gch", -- Highlight surrounding
      replace = "gcr", -- Replace surrounding
      update_n_lines = "gcn", -- Update `n_lines`
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
