local deep_get = require("utils.deep_get")
local is_tty = require("utils.is_tty")
local tbl_extend = require("utils.tbl_extend")
-- Don't change anything if not in a tty
if not is_tty() then
  return {
    -- Avoid attempting to clean for no reason
    { "uga-rosa/utf8.nvim", cond = false },
  }
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, config)
      return tbl_extend(config, {
        default_component_configs = {
          indent = {
            expander_collapsed = "▶",
            expander_expanded = "▼",
          },
          icon = {
            folder_closed = "-",
            folder_open = "+",
            folder_empty = "_",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "x", -- this can only be used in the git_status source
              renamed = "->", -- this can only be used in the git_status source
              -- Status type
              untracked = "?",
              ignored = "/",
              unstaged = "_",
              staged = "+",
              conflict = "!",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    cond = false, -- Disable it
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "seoul256",
        icons_enabled = false,
        section_separators = { left = ">", right = "<" },
        component_separators = { left = ">", right = "<" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "|" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = ":" },
        untracked = { text = "?" },
      },
    },
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "uga-rosa/utf8.nvim" },
    opts = function(_, opts)
      local utf8 = require("utils.utf8")
      local group = deep_get(opts, "section", "buttons", "val")
      if not group then return end
      for _, cgroup in ipairs(group) do
        cgroup.val = utf8.sub(cgroup.val, 2)
      end
    end,
  },
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      prompt = {
        prefix = { { "Flash: ", "FlashPromptIcon" } },
      },
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        ---@type table<string, CmdlineFormat>
        format = {
          cmdline = { icon = "> " },
          search_down = { icon = "/ " },
          search_up = { icon = "? " },
          filter = { icon = "$" },
          lua = { icon = "L " },
          help = { icon = "? " },
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    ---@type LazyVimConfig
    opts = {
      -- icons used by other plugins
      icons = {
        dap = {
          Stopped = { "-> ", "DiagnosticWarn", "DapStoppedLine" },
          Breakpoint = "X ",
          BreakpointCondition = "? ",
          BreakpointRejected = { "! ", "DiagnosticError" },
          LogPoint = ".>",
        },
        diagnostics = {
          Error = "X ",
          Warn = "! ",
          Hint = "-? ",
          Info = "I ",
        },
        git = {
          added = "+ ",
          modified = "M ",
          removed = "- ",
        },
        kinds = {
          Array = "[] ",
          Boolean = "",
          Class = "",
          Color = "",
          Constant = "",
          Constructor = "",
          Copilot = "",
          Enum = "",
          EnumMember = "",
          Event = "",
          Field = "",
          File = "File ",
          Folder = "Folder ",
          Function = "Func ",
          Interface = "",
          Key = "ABC ",
          Keyword = "",
          Method = "Method ",
          Module = "Mod ",
          Namespace = "{} ",
          Null = "NULL ",
          Number = "# ",
          Object = "{} ",
          Operator = "+- ",
          Package = "",
          Property = "",
          Reference = "",
          Snippet = "",
          String = "",
          Struct = "",
          Text = "",
          TypeParameter = "<T> ",
          Unit = "",
          Value = "ABC ",
          Variable = "<V> ",
        },
      },
    },
  },
}
