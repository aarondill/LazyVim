return function()
  -- false if display is defined, else true
  return not vim.env.DISPLAY
end
