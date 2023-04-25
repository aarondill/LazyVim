---Opens the nearest `filename` in the editor, or prints notifies
---@param filename string the filename to seach for
---@return boolean success true if file found, false if not found
return function(filename)
  local match = vim.fs.find(filename, {
    upward = true,
    limit = 1,
    type = "file",
  })

  if #match == 0 then
    vim.notify("Could not find file: " .. filename)
    return false
  end

  local file = match[1]
  vim.notify("Editing " .. vim.fn.fnamemodify(file, ":~:."))
  vim.cmd.edit(file)
  return true
end
