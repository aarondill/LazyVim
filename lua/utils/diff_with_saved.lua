return function()
  local filetype = vim.o.ft
  vim.cmd.diffthis()

  vim.cmd.vnew()
  local orig_file = vim.fn.expand("#")
  vim.cmd.read(orig_file)
  vim.cmd("normal! 1Gdd")

  vim.cmd.diffthis()
  vim.opt.buftype = "nofile"
  vim.opt.bufhidden = "wipe"
  vim.opt.buflisted = false
  vim.opt.swapfile = false
  vim.opt.readonly = true
  vim.opt.filetype = filetype
end
