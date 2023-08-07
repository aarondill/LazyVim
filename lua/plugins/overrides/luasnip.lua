return {
  "L3MON4D3/LuaSnip",
  config = function(opts)
    require("luasnip").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets/" })
  end,
  -- Disable LuaSnip capture of tab
  keys = function()
    return {
      {
        "<tab>",
        function()
          if require("luasnip").jumpable(1) then
            require("luasnip").jump(1)
          else
            require("tabnine.keymaps").accept_suggestion()
          end
        end,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          if require("luasnip").jumpable(1) then
            require("luasnip").jump(1)
          else
            require("tabnine.keymaps").accept_suggestion()
          end
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          if require("luasnip").jumpable(-1) then require("luasnip").jump(-1) end
        end,
        mode = { "i", "s" },
      },
    }
  end,
}
