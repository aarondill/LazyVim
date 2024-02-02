local ensure_installed_table = {
  "lua-language-server", -- lua
  "bash-language-server", -- bash
  -- "clangd", -- cpp
  "cspell", -- spelling
  "eslint-lsp", -- eslint
  "eslint_d", -- eslint
  -- "gopls", -- go
  "jdtls", -- java
  "json-lsp", -- json
  "prettier", --prettier
  "shellcheck", --shell
  "taplo", -- toml
  "typescript-language-server", -- Typescript
  "vim-language-server", -- vimscript
  "vint", -- vimscript
}

return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    opts = opts or {}
    opts.ensure_installed = opts.ensure_installed or {}
    if type(opts.ensure_installed) ~= "table" then opts.ensure_installed = { opts.ensure_installed } end
    vim.list_extend(opts.ensure_installed, ensure_installed_table)
  end,
}
