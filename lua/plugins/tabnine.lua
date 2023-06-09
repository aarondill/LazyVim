return {
  -- Tabnine setup
  {
    "aarondill/tabnine-nvim",
    -- dev = true,
    -- branch = "chat",
    branch = "all_together_now",
    build = "./dl_binaries.sh",
    event = { "BufReadPre", "BufNewFile" },
    cmd = {
      "TabnineChat",
      "TabnineChatClear",
      "TabnineChatClose",
      "TabnineChatNew",
      "TabnineDisable",
      "TabnineEnable",
      "TabnineHub",
      "TabnineHubUrl",
      "TabnineLogin",
      "TabnineLogout",
      "TabnineStatus",
      "TabnineToggle",
    },
    main = "tabnine",
    opts = {
      disable_auto_comment = false, -- I already handle this. Default: true
      accept_keymap = "<C-S-F35>", -- Default: "<Tab>" -- This is *effectively* disabled. there's no true way to disable it.
      dismiss_keymap = "<C-]>", -- Default: "<C-]>"
      debounce_ms = 500, -- Faster pls. Default: 800
      suggestion_color = { gui = "#808080", cterm = 244 }, -- Default: { gui = "#808080", cterm = 244 }
      exclude_filetypes = { "TelescopePrompt" }, -- Default: { "TelescopePrompt" }
    },
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
        mapping = {
          -- Accept without explicit selection
          ["<TAB>"] = cmp.mapping(function(fallback)
            local tabnine_keymaps = require("tabnine.keymaps")
            if tabnine_keymaps.accept_suggestion and tabnine_keymaps.accept_suggestion() then
              return
            elseif cmp.visible() then
              cmp.confirm({ select = false })
            else
              -- Fallback is not mapped correctly. Just hard code a tab character
              vim.api.nvim_feedkeys("\t", "n", false)
              -- fallback()
            end
          end, { "i" }),
        },
      })
    end,
  },
}
