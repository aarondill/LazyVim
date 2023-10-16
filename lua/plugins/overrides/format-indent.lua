return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      -- Set stylua to use the current shift width
      ---@type conform.FormatterConfigOverride
      stylua = {
        prepend_args = function(ctx)
          local bufutils = require("utils.buf")
          local i = bufutils.get_indent(ctx.buf)
          return {
            "--indent-width",
            i.size,
            "--indent-type",
            i.tabs and "Tabs" or "Spaces",
          }
        end,
      },

      -- Set shfmt to use the current shift width
      ---@type conform.FormatterConfigOverride
      shfmt = {
        prepend_args = function(ctx)
          local bufutils = require("utils.buf")
          local i = bufutils.get_indent(ctx.buf)
          return { "-i", i.tabs and 0 or i.size }
        end,
      },
    },
  },
}
