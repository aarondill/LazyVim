-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local api = vim.api
local NEW_BUF_EVENTS = { "BufReadPost", "BufNewFile" }
local VimRCAutoCmds = api.nvim_create_augroup("VimRCAutoCmds", { clear = true })
-- Stop recording of dir history
vim.g.netrw_dirhistmax = 0
-- Change .conf syntax highlighting to an aproximate
api.nvim_create_autocmd(NEW_BUF_EVENTS, {
  desc = "Change .conf syntax highlighting to an aproximate",
  group = VimRCAutoCmds,
  pattern = "*.conf",
  command = "set syntax=dosini",
})
-- api.nvim_create_autocmd(NEW_BUF_EVENTS, {
--   desc = "Disable formatting if .noformat file"
-- })

-- Disable auto-comments!!!
api.nvim_create_autocmd("FileType", {
  desc = "Disable auto-comments",
  group = VimRCAutoCmds,
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

api.nvim_create_autocmd(NEW_BUF_EVENTS, {
  pattern = "*.tmpl",
  group = VimRCAutoCmds,
  callback = function(ev)
    ---@type string
    local file = ev.file or ""
    local ext, count = file:sub(2):gsub(".+%.(.+).tmpl$", "%1")
    if count == 0 then
      vim.notify("Could not determine template extension for " .. file)
      return
    end
    vim.opt.filetype = ext
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  desc = "hack to work around Neovim bug",
  pattern = "*",
  group = VimRCAutoCmds,
  callback = function()
    -- HACK: Work around https://github.com/neovim/neovim/issues/21856
    -- causing exit code 134 on :wq
    vim.cmd.sleep({ args = { "1m" } })
  end,
})
