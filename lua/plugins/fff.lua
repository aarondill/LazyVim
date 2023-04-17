return {
  "dylanaraps/fff.vim",
  cmd = { "F" },
  init = function()
    vim.g["fff#split"] = "10new"
    vim.g["fff#split_direction"] = "splitbelow splitright"
    -- Open fff on press of 'f'
    require("util").set_key_map("n", "fff", "<CMD>F<CR>", "Open fff")
  end,
}
