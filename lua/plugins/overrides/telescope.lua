local icons = require("config.icons")
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      prompt_prefix = icons["telescope"].prompt_prefix,
      selection_caret = icons["telescope"].selection_caret,
    },
  },
}
