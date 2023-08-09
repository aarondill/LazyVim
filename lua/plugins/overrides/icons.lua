local icons = require("config.icons")
return {
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      prompt = {
        prefix = { { icons.flash_prompt, "FlashPromptIcon" } },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = icons.gitsigns.add },
        change = { text = icons.gitsigns.change },
        delete = { text = icons.gitsigns.delete },
        topdelete = { text = icons.gitsigns.topdelete },
        changedelete = { text = icons.gitsigns.changedelete },
        untracked = { text = icons.gitsigns.untracked },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        defaults = {
          prompt_prefix = icons["telescope"].prompt_prefix,
          selection_caret = icons["telescope"].selection_caret,
        },
      },
    },
  },
}
