local filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" } -- filetypes where the plugin is active
---@type LazySpec
return {
  "https://github.com/axelvc/template-string.nvim",
  ft = filetypes, -- lazy load it
  opts = {
    filetypes = filetypes,
    jsx_brackets = true, -- must add brackets to JSX attributes
    remove_template_string = false, -- remove backticks when there are no template strings
  },
}
