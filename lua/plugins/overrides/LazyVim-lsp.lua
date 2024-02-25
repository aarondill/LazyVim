local M = require("lazyvim.plugins.lsp.keymaps")
---@diagnostic disable-next-line: duplicate-set-field
M.get = function() ---@return LazyKeysLspSpec[]
  if M._keys then return M._keys end
    -- stylua: ignore
    M._keys =  {
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
      { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      }
    }
  local rename = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
  if require("lazyvim.util").has("inc-rename.nvim") then
    rename = {
      "<leader>cr",
      function() return ":" .. require("inc_rename").config.cmd_name .. " " .. vim.fn.expand("<cword>") end,
      expr = true,
      desc = "Rename",
      has = "rename",
    }
  end
  M._keys[#M._keys + 1] = rename
  return M._keys
end

return {}
