---@type LazySpec
return {
  "alker0/chezmoi.vim",
  lazy = false,
  -- Really big number ¯\_(ツ)_/¯ (default: 50)
  priority = 1001,
  init = function()
    vim.g["chezmoi#use_external"] = 1
  end,
}
