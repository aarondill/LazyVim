return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    for k, v in ipairs(opts.sources) do
      local nls = require("null-ls")
      if v == nls.builtins.formatting.shfmt then
        -- Add "-i 2" to arguments for shfmt
        opts.sources[k] = require("null-ls").builtins.formatting.shfmt.with({ extra_args = { "-i", "2" } })
      end
    end
  end,
}
