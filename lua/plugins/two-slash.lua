---@type LazySpec
return {
  {
    "marilari88/twoslash-queries.nvim",
    lazy = true,
    opts = {
      multi_line = true, -- to print types in multi line mode
      is_enabled = true, -- to keep disabled at startup and enable it on request with the TwoslashQueriesEnable
      highlight = "Constant", -- to set up a highlight group for the virtual text
    },
    ft = "typescript",
    cmd = {
      "TwoslashQueriesEnable",
      "TwoslashQueriesDisable",
      "TwoslashQueriesInspect",
      "TwoslashQueriesRemove",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type lspconfig.options.tsserver
        ---@diagnostic disable-next-line: missing-fields
        tsserver = {
          on_attach = function(client, bufnr) return require("twoslash-queries").attach(client, bufnr) end,
        },
      },
    },
  },
}
