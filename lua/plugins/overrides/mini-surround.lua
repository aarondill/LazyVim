return {
  "echasnovski/mini.surround",
  keys = function(_, keys)
    local chars = {
      "(",
      "{",
      "'",
      -- Following don't work until loaded
      '"',
      "[",
    }
    for _, c in ipairs(chars) do
      keys[#keys + 1] = {
        c,
        ([[:<C-u>lua MiniSurround.add('visual')<CR>]] .. c),
        desc = "Surround selection with " .. c,
        mode = "x",
      }
    end
  end,
}
