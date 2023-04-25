-- Setup user commands here. This is laoded by init.lua

vim.api.nvim_create_user_command("DiffSaved", require("utils.diff_with_saved"), {})
