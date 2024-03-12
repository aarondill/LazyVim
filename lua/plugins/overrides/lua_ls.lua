local library = {}
--- TODO: remove this when possible!
if vim.fn.has("nvim-0.10") == 1 then library[#library + 1] = (require("neodev.config").types()) end
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ---@type lspconfig.options.lua_ls
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              library = library,
            },
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
