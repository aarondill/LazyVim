-- View telescope pickers and chose one to run (mapped to <leader>t)
return {
  "keyvchan/telescope-find-pickers.nvim",
  config = function()
   local ok, mod= pcall(require("telescope"))
   if ok then
     mod.load_extension("find_pickers")
   end
  end,
  keys = function(ext)
    return {
      {
        "<leader>t",
        require("telescope").extensions.find_pickers.find_pickers,
        desc = "Find Telescope pickers",
        mode = "n",
      },
    }
  end,
}
