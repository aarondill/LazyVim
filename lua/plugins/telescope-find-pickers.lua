-- View telescope pickers and chose one to run (mapped to <leader>t)
return {
  "keyvchan/telescope-find-pickers.nvim",
  mapping = "<leader>t",
  config = function()
    require("telescope").load_extension("find_pickers")
  end,
  keys = function(ext)
    return {
      {
        ext.mapping,
        require("telescope").extensions.find_pickers.find_pickers,
        desc = "Find Telescope pickers",
        mode = "n",
      },
    }
  end,
}
