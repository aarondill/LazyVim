---@type LazySpec
return {
  "folke/noice.nvim",
  ---@type NoiceConfig
  opts = {
    markdown = {
      hover = {
        ["|(%S-)|"] = vim.cmd.help, -- vim help links
        ["%[.-%]%((%S-)%)"] = function(uri) -- markdown links
          local files = require("utils.files")
          if vim.startswith(uri, "jdt://") then
            -- If the url is a jdt file, open it in a new tab
            -- note: jdtls will handle the url properly and open the documentation
            return files.open(uri)
          elseif vim.startswith(uri, "file://") then
            local file = vim.uri_to_fname(uri)
            return files.open(file)
          elseif not uri:match("^.*://") then
            -- This "uri" doesn't have a scheme, so it's probably a filepath
            return files.open(uri)
          end
          return require("lazy.util").open(uri)
        end,
      },
    },
  },
}
