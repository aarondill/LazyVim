-- View telescope pickers and chose one to run (mapped to <leader>t)
return {
  "keyvchan/telescope-find-pickers.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  config = function()
    local ok, mod = pcall(require, "telescope")
    if ok then
      mod.load_extension("find_pickers")
    end
  end,
  keys = function(ext)
    local ok, tlsp = pcall(require, "telescope")
    if not ok then
      return {}
    end
    return {
      {
        "<leader>t",
        tlsp.extensions.find_pickers.find_pickers,
        desc = "Find Telescope pickers",
        mode = "n",
      },
    }
  end,
}
