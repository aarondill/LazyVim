return {
  "sudormrfbin/cheatsheet.nvim",

  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
  keys = { "<leader>?" },
  -- Map my own key bc it isn't set when lazy.vim sets it
  config = function(_, opts)
    require("cheatsheet").setup(opts)
    vim.keymap.set("n", "<Leader>?", "<cmd>Cheatsheet<CR>")
  end,
  cmd = { "Cheatsheet", "CheatsheetEdit" },
}
