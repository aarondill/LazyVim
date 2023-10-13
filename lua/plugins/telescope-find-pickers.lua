-- View telescope pickers and chose one to run (mapped to <leader>t)
---@type LazySpec
return {
  "keyvchan/telescope-find-pickers.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  config = function()
    local ok, mod = pcall(require, "telescope")
    if ok then mod.load_extension("find_pickers") end
  end,
  keys = {
    {
      "<leader>t",
      function()
        local ok, tlsp = pcall(require, "telescope")
        assert(ok, "telescope-find-pickers requires telescope! Please ensure it's installed")
        return tlsp.extensions.find_pickers.find_pickers()
      end,
      desc = "Find Telescope pickers",
      mode = "n",
    },
  },
}
