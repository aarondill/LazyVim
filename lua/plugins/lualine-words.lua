local function wordcount()
  -- wordcount.bytes - Number of bytes in the buffer
  -- wordcount.chars - Number of chars in the buffer
  -- wordcount.words - Number of words in the buffer
  local wordcount_dict = vim.fn.wordcount()
  -- local mins = tostring(math.ceil(words / 200)) -- 200 wpm
  return string.format("%dw%dc", wordcount_dict.words, wordcount_dict.chars)
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, { wordcount })
  end,
}
