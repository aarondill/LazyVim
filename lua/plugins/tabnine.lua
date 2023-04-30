return {
  -- Tabnine setup
  {
    "aarondill/tabnine-nvim",
    branch = "refactor_export_keymaps",
    build = "./dl_binaries.sh",
    event = { "BufReadPre", "BufNewFile" },
    main = "tabnine",
    opts = {
      disable_auto_comment = false, -- I already handle this. Default: true
      accept_keymap = "<Tab>", -- Default: "<Tab>"
      dismiss_keymap = "<C-]>", -- Default: "<C-]>"
      debounce_ms = 500, -- Faster pls. Default: 800
      suggestion_color = { gui = "#808080", cterm = 244 }, -- Default: { gui = "#808080", cterm = 244 }
      exclude_filetypes = { "TelescopePrompt" }, -- Default: { "TelescopePrompt" }
    },
  },

  -- Disable LuaSnip capture of tab
  {
    "L3MON4D3/LuaSnip",
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
            if require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            end
          end,
          mode = { "i", "s" },
        },
      }
    end,
  },
  -- Lualine show Tabnine status
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_b, "tabnine")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
      return vim.tbl_deep_extend("force", opts or {}, {
        experimental = {
          -- Don't show the ghost text (shown by tabnine)
          ghost_text = false,
        },
        mapping = {
          -- Accept without explicit selection
          ["<TAB>"] = function(fallback)
            if not require("tabnine.keymaps").accept_suggestion() then
              cmp.mapping.confirm({ select = true })(fallback)
            end
          end,
        },
      })
    end,
  },
}
