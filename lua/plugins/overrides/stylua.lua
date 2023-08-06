return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    for k, v in ipairs(opts.sources) do
      local nls = require("null-ls")
      if v == nls.builtins.formatting.stylua then
        opts.sources[k] = require("null-ls").builtins.formatting.stylua.with({
          -- Set shfmt to use the current shift width
          extra_args = function(params)
            local lsp_opts = params.options
            ---@type string
            local tabSize, type

            if not lsp_opts then
              -- No options are defined, default to two spaces
              tabSize, type = "2", "Spaces"
            elseif lsp_opts.insertSpaces == false then
              tabSize, type = "1", "Tabs" -- If using tab indentation, use tabs
            elseif lsp_opts.insertSpaces and lsp_opts.tabSize then
              tabSize, type = lsp_opts.tabSize, "Spaces" -- Use spaces, according to the current settings
            end

            return { "--indent-width", tabSize, "--indent-type", type }
          end,
        })
      end
    end
  end,
}
