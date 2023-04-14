---@type LazySpec
return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true, -- Enable this to disable setting the background color
      dim_inactive = true, -- dims inactive windows
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000", -- Set to transparent (to avoid error notification)
    },
  },
}
