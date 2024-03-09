return {
  -- lsp symbol navigation for lualine. This shows where
  -- in the code structure you are - within functions, classes,
  -- etc - in the statusline.
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf ---@type number
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        return require("nvim-navic").attach(client, buffer)
      end,
    })
  end,
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      separator = " ",
      highlight = true,
      depth_limit = 5,
      icons = require("lazyvim.config").icons.kinds,
      lazy_update_context = true,
    })
  end,
}
