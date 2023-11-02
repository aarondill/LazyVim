---@type LazySpec
return {
  {
    "https://github.com/marilari88/twoslash-queries.nvim",
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
    -- config = function(_, opts)
    -- require('lazyvim.util').lsp.on_attach(on_attach)
    -- require("twoslash-queries").setup(opts),
    -- end
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {
          settings = nil, ---@diagnostic disable-line :assign-type-mismatch
          on_attach = function(client, bufnr)
            return require("twoslash-queries").attach(client, bufnr)
          end,
        },
      },
    },
  },
}
