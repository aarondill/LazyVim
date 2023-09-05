local set_key_map = require("utils.set_key_map")
local vtext = require("utils.vtext")
return {
  "chrishrb/gx.nvim",
  event = { "BufEnter" },
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    set_key_map({ "n", "x" }, "gf", function()
      local cursor_file = vtext() or vim.fn.expand("<cfile>")
      if type(cursor_file) == "string" and cursor_file:match("^https?://.*$") then
        vim.cmd("norm gx")
      else
        vim.cmd("norm! gf")
      end
    end)
  end,
  config = true,
}
