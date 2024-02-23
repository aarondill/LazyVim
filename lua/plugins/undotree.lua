---@type LazySpec
return {
  "mbbill/undotree",
  keys = {
    {
      "<leader>u",
      "<Cmd>UndotreeToggle<Cr>",
      mode = "n",
      desc = "Toggle Undotree",
    },
  },
  init = function() -- ensure undofile is true
    if vim.fn.has("persistent_undo") ~= 1 then return end
    vim.opt.undofile = true
  end,
}
