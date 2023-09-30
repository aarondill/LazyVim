return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    for k, v in ipairs(opts.sources) do
      local nls = require("null-ls")
      if v == nls.builtins.formatting.shfmt then
        opts.sources[k] = require("null-ls").builtins.formatting.shfmt.with({
          -- Set shfmt to use the current shift width
          extra_args = function(params)
            local lsp_opts = params.options
            ---@type string
            local tabSize

            if not lsp_opts then
              tabSize = "2" -- No options are defined, default to two spaces
            elseif lsp_opts.insertSpaces == false then
              tabSize = "0" -- If using tab indentation, use tabs
            elseif lsp_opts.insertSpaces and lsp_opts.tabSize then
              tabSize = lsp_opts.tabSize -- Use spaces, according to the current settings
            end

            return { "-i", tabSize }
          end,
        })
      end
    end
  end,
}
