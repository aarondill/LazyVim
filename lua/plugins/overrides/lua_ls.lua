return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ---@type lspconfig.options.lua_ls
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              -- use @ to fix a mistake (default)
              postfix = "@",
              callSnippet = "Disable",
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
