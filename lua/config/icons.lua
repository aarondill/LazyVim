---@class custom_icons
--- Icons will be automatically pulled from tty if necessary
--- Icons will otherwise be gotten from gui, falling back to the tty icon if not available
--- Note: this only works on the top level. if a table is returned, no such promises are made.
local tty = {
  clock = "",
  debug = "debug ",
  lualine = {
    section_separators = { left = ">", right = "<" },
    component_separators = { left = "|", right = "|" },
    filename_symbols = { modified = " M ", readonly = "RO ", unnamed = "" },
  },
  ["neo-tree"] = {
    default_component_configs = {
      modified = {
        symbol = "[+] ",
      },
      indent = {
        indent_marker = "|",
        last_indent_marker = ">",
        expander_collapsed = "▶",
        expander_expanded = "▼",
      },
      icon = {
        folder_closed = "-",
        folder_open = "+",
        folder_empty = "_",
        folder_empty_open = "_>",
        default = "*",
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
  },
  telescope = {
    prompt_prefix = "> ",
    selection_caret = "> ",
  },
  flash_prompt = "Flash: ",
  noice = {
    cmdline = "> ",
    search_down = "/ ",
    search_up = "? ",
    filter = "$",
    lua = "L ",
    help = "? ",
  },
  gitsigns = {
    add = "+",
    change = "|",
    delete = "-",
    topdelete = "-",
    changedelete = ":",
    untracked = "?",
  },
  lazyvim = {
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
      Hint = "> ",
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
}
---@class custom_icons
local gui = {
  clock = " ",
  debug = " ",
  ["neo-tree"] = {
    default_component_configs = {
      git_status = {
        symbols = {
          added = "✚",
          conflict = "",
          deleted = "✖",
          ignored = "",
          modified = "",
          renamed = "󰁕",
          staged = "",
          unstaged = "󰄱",
          untracked = "",
        },
      },
      icon = {
        default = "*",
        folder_closed = "",
        folder_empty = "󰜌",
        folder_empty_open = "󰜌",
        folder_open = "",
      },
      indent = {
        expander_collapsed = "",
        expander_expanded = "",
        indent_marker = "│",
        last_indent_marker = "└",
      },
      modified = {
        symbol = "[+] ",
      },
    },
  },

  lualine = {
    section_separators = {
      left = "",
      right = "",
    },
    component_separators = {
      left = "|",
      right = "|",
    },
    filename_symbols = { modified = "  ", readonly = "󰌾 ", unnamed = "" },
  },
  lazyvim = {
    dap = {
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    },
    diagnostics = {
      Error = " ",
      Hint = " ",
      Info = " ",
      Warn = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Array = " ",
      Boolean = " ",
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Copilot = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Namespace = " ",
      Null = " ",
      Number = " ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    },
  },
  telescope = {
    prompt_prefix = " ",
    selection_caret = " ",
  },
  gitsigns = {
    add = "▎",
    change = "▎",
    changedelete = "▎",
    delete = "",
    topdelete = "",
    untracked = "▎",
  },
  flash_prompt = "⚡",
}

---@class icons :custom_icons
---@field TTY_ICONS custom_icons Use this special key to specify that icons should come from the tty set (only useful in gui environments)
local M = setmetatable({}, {
  __index = function(_, key)
    if key == "TTY_ICONS" then return tty[key] end
    local is_tty = require("utils.is_tty")
    -- If not tty, use gui. If tty or gui not exist, use tty instead
    return not is_tty() and gui[key] or tty[key]
  end,
})
return M
