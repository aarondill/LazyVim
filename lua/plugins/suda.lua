return {
  "lambdalisue/suda.vim",
  cond = vim.fn.executable("sudo"),
  config = function()
    vim.g.suda_smart_edit = 1
  end,
}
