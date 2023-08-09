return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    for i, section in ipairs(opts.sections.lualine_y) do
      if section and section[1] == "diff" then
        -- remove the diff section
        -- This is fine, because lualine skips nil indicies
        opts.sections.lualine_y[i] = nil
      end
    end
  end,
}
