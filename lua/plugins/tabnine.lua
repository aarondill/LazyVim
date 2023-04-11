return {
  -- Tabnine setup
  {
    "aarondill/tabnine-nvim",
    branch = "all_together_now",
    build = "./dl_binaries.sh",
    event = "VeryLazy",
    main = "tabnine",
    opts = {
      disable_auto_comment = true,
      accept_keymap = "<Tab>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = { "TelescopePrompt" },
    },
  },
  -- Disable LuaSnip capture of tab
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- Lualine show Tabnine status
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_b, "tabnine")
    end,
  },
}
