return {
  "uga-rosa/ugaterm.nvim",
  opts = {
    ---@type string The terminal buffer name prefix.
    prefix = "ugaterm",
    ---@type string The filetype for a terminal buffer.
    filetype = "ugaterm",
    ---@type string|function Command|function to open a teminal window.
    open_cmd = "botright 15sp",
  },
  cmd = {
    "UgatermOpen",
    "UgatermNew",
    "UgatermHide",
    "UgatermToggle",
    "UgatermSelect",
    "UgatermDelete",
    "UgatermRename",
  },
  keys = {
    { "<leader><CR>", "<CMD>UgatermToggle<CR>", desc = "Toggle the terminal", mode = "n" },
  },
}
