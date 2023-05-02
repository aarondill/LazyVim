-- You can include the error code with the following init.lua configuration

local diag_format = function(d)
  if d.code then
    return string.format("%s (%s)", d.message, d.code)
  else
    return d.message
  end
end
return {
  "neovim/nvim-lspconfig",

  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        format = diag_format,
      },
      float = {
        prefix = "",
        suffix = "",
        format = diag_format,
        source = true,
      },
      severity_sort = true,
    },
  },
}
