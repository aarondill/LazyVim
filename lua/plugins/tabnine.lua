local use_tabnine = require("utils.root_safe")

local use_upstream = false

---@type LazySpec
return {
  -- Tabnine setup
  {
    (use_upstream and "codota" or "aarondill") .. "/tabnine-nvim",
    dev = false,

    cond = use_tabnine,
    branch = use_upstream and "master" or "all_together_now",
    build = use_upstream and "./dl_binaries.sh" or nil, -- Note: nil means use build.lua
    event = { "LazyFile" },
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
      accept_keymap = "<C-[>", -- Default: "<Tab>" -- This is *effectively* disabled. there's no true way to disable it.
      dismiss_keymap = "<C-]>", -- Default: "<C-]>"
      debounce_ms = 500, -- Faster pls. Default: 800
      suggestion_color = { gui = "#808080", cterm = 244 }, -- Default: { gui = "#808080", cterm = 244 }
      exclude_filetypes = { "TelescopePrompt" }, -- Default: { "TelescopePrompt" }
      codelens_enabled = false,
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
