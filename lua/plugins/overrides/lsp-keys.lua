return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    local ret = {} -- avoid modifying the table as we iterate
    for _, v in ipairs(keys) do
      if v[2] == vim.lsp.buf.signature_help and v.mode == "i" then
        -- Noop. Remove this keymap
      elseif v.desc:upper() == "RENAME" then -- Search for the rename command
        local copy = vim.deepcopy(v) -- Copy so I can modify it
        copy[1] = "<F2>" -- Change keymap of copy to F2
        ret[#ret + 1] = copy -- Append to keys table
      else
        ret[#ret + 1] = v
      end
    end

    for i = 0, #keys do -- clear the keys table
      keys[i] = nil
    end
    for i, v in ipairs(ret) do -- copy all ret values into keys
      keys[i] = v
    end
  end,
}
