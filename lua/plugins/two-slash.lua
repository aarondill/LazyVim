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
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client.name then return end
          if client.name ~= "tsserver" then return end
          return require("twoslash-queries").attach(client, buffer)
        end,
      })
    end,
  },
}
