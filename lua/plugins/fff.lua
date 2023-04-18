---@type LazySpec
return {
  {
    "dylanaraps/fff",
    build = "chmod +x fff", -- should be, but make sure
    config = function()
      local util = require("util")
      local bin = vim.fn.stdpath("data") .. "/lazy/fff"

      if not vim.loop.fs_stat(bin) then
        vim.notify("fff folder could not be found", vim.log.levels.ERROR)
        return
      end

      util.extend_path(bin)
    end,
    lazy = true, -- don't load until fff.vim calls as dependency
  },
  {
    "aarondill/fff.vim",
    dependencies = "dylanaraps/fff", -- load fff for executable
    cmd = { "F" }, -- Only load on :F
    init = function()
      -- Open on bottom
      vim.g["fff#split"] = "10new"
      vim.g["fff#split_direction"] = "splitbelow splitright"
      -- Open fff on press of '<leader>f'
      require("util").set_key_map("n", "<leader>f", "<CMD>F %:p:h:S<CR>", "Open fff")
    end,
  },
}
