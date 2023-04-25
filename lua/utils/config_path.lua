--- Return the config path (deafult path: ~/.config/nvim)
---@return string
return function()
  ---@diagnostic disable-next-line: return-type-mismatch # Built in vim.fn.stdpath works, catppuccin messes the type up
  return vim.fn.stdpath("config")
end
