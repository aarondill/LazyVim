--- TODO: remove this when possible!
vim.api.nvim_create_autocmd("LspAttach", {
  once = true, -- we don't need to modify the table more than once
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "lua_ls" then return end
    local has_neodev, neodev = pcall(require, "neodev.config")
    if not has_neodev then return end
    local neodev_types = assert(neodev.types()) ---@type string
    ---@type lspconfig.options.lua_ls|vim.lsp.ClientConfig
    client.config =
      vim.tbl_deep_extend("keep", client.config, { settings = { Lua = { workspace = { library = {} } } } })
    --- Already has it :)
    if vim.tbl_contains(client.config.settings.Lua.workspace.library, neodev_types) then return end
    table.insert(client.config.settings.Lua.workspace.library, neodev_types)
    assert(client.notify("workspace/didChangeConfiguration"), "Lsp server has shutdown!")
  end,
})

---@type LazySpec
return { ---@diagnostic disable: missing-fields
  {
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
  },
}
