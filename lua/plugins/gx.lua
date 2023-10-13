---@param err string
---@return string
local function get_err_str(err)
  local _, m = err:match("(%S*%(%):%s*Vim%(%S*%):%s*)(.*)")
  return m or err
end
---@type LazySpec
return {
  "chrishrb/gx.nvim",
  event = { "LazyFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "gx" },
    {
      "gf",
      function()
        local vtext = require("utils.vtext")
        local cursor_file = vtext() or vim.fn.expand("<cfile>")
        -- Found a url. Use gx to open it!
        if type(cursor_file) == "string" and cursor_file:match("^https?://.*$") then return vim.cmd("norm gx") end

        ---Emulate vim's nicer error notifs:
        ---@diagnostic disable-next-line :param-type-mismatch vim.cmd can be called. let me.
        local ok, err = pcall(vim.cmd, "norm! gf")
        if ok then return end
        return vim.notify(get_err_str(err), vim.log.levels.ERROR) -- notify on error
      end,
      mode = { "v", "n" },
    },
  },
  config = true,
}
