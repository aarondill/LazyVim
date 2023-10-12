local bufutils = require("utils.buf")

---@generic Ctx :conform.Context|conform.RangeContext
---@param ctx Ctx
---@param args string|string[]|fun(ctx: Ctx):(string[]|string)
---@return string[]|string
local function extract(args, ctx)
  if type(args) == "function" then return args(ctx) or {} end
  return args or {}
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      -- Set stylua to use the current shift width
      ---@type conform.FormatterConfig
      stylua = {
        command = "stylua", -- Required for type checking.
        args = function(ctx)
          local args = extract(require("conform.formatters.stylua").args, ctx) ---@cast args string[]|{n: integer?}
          if type(args) == "string" then return args end -- I give up.
          local i = bufutils.get_indent(ctx.buf)
          return {
            "--indent-width",
            tostring(i.size),
            "--indent-type",
            i.tabs and "Tabs" or "Spaces",
            unpack(args, 1, args.n),
          } -- Unpack must be last.
        end,
        range_args = function(ctx)
          local args = extract(require("conform.formatters.stylua").range_args, ctx)
          if type(args) == "string" then return args end -- I give up.
          local i = bufutils.get_indent(ctx.buf) ---@cast args string[]|{n: integer?}
          return {
            "--indent-width",
            tostring(i.size),
            "--indent-type",
            i.tabs and "Tabs" or "Spaces",
            unpack(args, 1, args.n),
          }
        end,
      },

      -- Set shfmt to use the current shift width
      ---@type conform.FormatterConfig
      shfmt = {
        command = "shfmt", -- Required for type checking.
        args = function(ctx)
          local args = extract(require("conform.formatters.shfmt").args, ctx)
          if type(args) == "string" then return args end -- I give up.
          local i = bufutils.get_indent(ctx.buf) ---@cast args string[]|{n: integer?}
          return { "-i", i.tabs and 0 or i.size, unpack(args, 1, args.n) }
        end,
      },
    },
  },
}
