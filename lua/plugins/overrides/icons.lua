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
}
