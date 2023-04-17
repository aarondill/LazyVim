return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type lspconfig.options
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              -- use @ to fix a mistake (default)
              postfix = "@",
            },
            hint = {
              -- Enable in case it starts working in future
              enable = true,
            },
          },
        },
      },
    },
  },
}
