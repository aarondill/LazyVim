return {
  "NvChad/nvterm",
  config = function()
    require("nvterm").setup()
  end,
  keys = {
    {
      "<leader><CR>",
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      desc = "Toggle the terminal",
      mode = "n",
    },
  },
}
-- require("nvterm.terminal").toggle "float"
-- require("nvterm.terminal").toggle "horizontal"
-- require("nvterm.terminal").toggle "vertical"
