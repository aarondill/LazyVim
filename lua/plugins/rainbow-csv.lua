return {
  "mechatroner/rainbow_csv",
  init = function()
    vim.g.disable_rainbow_key_mappings = 1
    vim.g.rbql_backend_language = "js"
    vim.g.disable_rainbow_hover = 1
  end,
  ft = {
    "csv",
    "tsv",
    "csv_semicolon",
    "csv_whitespace",
    "csv_pipe",
    "rfc_csv",
    "rfc_semicolon",
  },
  cmd = {
    "RainbowDelim",
    "RainbowMultiDelim",
    "NoRainbowDelim",
    "RainbowComment",
    "NoRainbowComment",
    "CSVLint",
    "RainbowAlign",
    "RainbowShrink",
    "Select",
    "Update",
    "RainbowName",
  },
}
