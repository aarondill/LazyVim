return {
  "echasnovski/mini.surround",
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
