return {
  "lambdalisue/suda.vim",
  cond = vim.fn.executable("sudo"),
  cmd = { "SudaRead", "SudaWrite" },
  -- init = function()
  --   vim.g.suda_smart_edit = 1
  -- end,
  -- -- Load on enter *any* file, required for smart editing.
  -- event = {
  --   "BufReadPre",
  --   "BufNewFile",
  --   -- "BufEnter"
  -- },
}
