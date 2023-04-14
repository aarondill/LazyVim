-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local api = vim.api
api.nvim_create_augroup("VimRCAutoCmds", { clear = true })
-- Stop recording of dir history
vim.g.netrw_dirhistmax = 0
-- Change .conf syntax highlighting to an aproximate
api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  desc = "Change .conf syntax highlighting to an aproximate",
  group = "VimRCAutoCmds",
  pattern = "*.conf",
  command = "setf dosini",
})

-- Disable auto-comments!!!
api.nvim_create_autocmd("FileType", {
  desc = "Disable auto-comments",
  group = "VimRCAutoCmds",
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})
