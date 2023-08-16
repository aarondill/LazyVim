return {
  "mechatroner/rainbow_csv",
  setup = function()
    vim.g.disable_rainbow_key_mappings = 1
    vim.g.rbql_backend_language = "js"
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
