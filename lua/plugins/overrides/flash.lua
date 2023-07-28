return {
  "folke/flash.nvim",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        -- Don't jump in search. This helps avoid jumping when there's no match for your search string
        jump = { history = false, register = false, nohlsearch = false },
      },
    },
  },
}
