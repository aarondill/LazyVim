return function(filename)
  local match = vim.fs.find(filename, {
    upward = true,
    limit = 1,
    type = "file",
  })
  if #match > 0 then
    local file = match[1]
    vim.notify("Editing " .. vim.fn.fnamemodify(file, ":~:."))
    vim.cmd.edit(file)
  else
    vim.notify("Could not find file: " .. filename)
  end
end
