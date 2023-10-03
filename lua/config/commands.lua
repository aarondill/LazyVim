-- Setup user commands here. This is laoded by init.lua

vim.api.nvim_create_user_command("DiffSaved", require("utils.diff_with_saved"), {})
vim.api.nvim_create_user_command("RandomLine", function()
  local l = math.random(1, vim.fn.line("$") or 1) -- Get random number upto last line
  vim.cmd("normal! " .. l .. "G")
end, {})
