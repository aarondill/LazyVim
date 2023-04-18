return {
  "neovim/nvim-lspconfig",
  init = function()
    -- Rename with <f2>
    local util = require("util")
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    for _, v in ipairs(keys) do -- Loop each value
      if v.desc:upper() == "RENAME" then -- Search for the rename command
        local copy = util.copy_table(v) -- Copy so I can modify it
        copy[1] = "<F2>" -- Change keymap of copy to F2
        keys[#keys + 1] = copy -- Append to keys table
        return -- Stop.
      end
    end
  end,
}
