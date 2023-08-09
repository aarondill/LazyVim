local icons = require("config.icons")
return {
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      prompt = {
        prefix = { { icons.flash_prompt, "FlashPromptIcon" } },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = icons.gitsigns.add },
        change = { text = icons.gitsigns.change },
        delete = { text = icons.gitsigns.delete },
        topdelete = { text = icons.gitsigns.topdelete },
        changedelete = { text = icons.gitsigns.changedelete },
        untracked = { text = icons.gitsigns.untracked },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        defaults = {
          prompt_prefix = icons["telescope"].prompt_prefix,
          selection_caret = icons["telescope"].selection_caret,
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        ---@type table<string, {icon: string}>
        format = {
          cmdline = { icon = icons.noice.cmdline.format.cmdline.icon },
          search_down = { icon = icons.noice.cmdline.format.search_down.icon },
          search_up = { icon = icons.noice.cmdline.format.search_up.icon },
          filter = { icon = icons.noice.cmdline.format.filter.icon },
          lua = { icon = icons.noice.cmdline.format.lua.icon },
          help = { icon = icons.noice.cmdline.format.help.icon },
          calculator = { icon = icons.noice.cmdline.format.calculator.icon },
          IncRename = { icon = icons.noice.cmdline.format.IncRename.icon },
        },
      },
      format = {
        level = {
          icons = {
            error = icons.noice.format.level.icons.error,
            info = icons.noice.format.level.icons.info,
            warn = icons.noice.format.level.icons.warn,
          },
        },
      },
      popupmenu = {
        kind_icons = {
          Class = icons.noice.popupmenu.kind_icons.Class,
          Color = icons.noice.popupmenu.kind_icons.Color,
          Constant = icons.noice.popupmenu.kind_icons.Constant,
          Constructor = icons.noice.popupmenu.kind_icons.Constructor,
          Enum = icons.noice.popupmenu.kind_icons.Enum,
          EnumMember = icons.noice.popupmenu.kind_icons.EnumMember,
          Field = icons.noice.popupmenu.kind_icons.Field,
          File = icons.noice.popupmenu.kind_icons.File,
          Folder = icons.noice.popupmenu.kind_icons.Folder,
          Function = icons.noice.popupmenu.kind_icons.Function,
          Interface = icons.noice.popupmenu.kind_icons.Interface,
          Keyword = icons.noice.popupmenu.kind_icons.Keyword,
          Method = icons.noice.popupmenu.kind_icons.Method,
          Module = icons.noice.popupmenu.kind_icons.Module,
          Property = icons.noice.popupmenu.kind_icons.Property,
          Snippet = icons.noice.popupmenu.kind_icons.Snippet,
          Struct = icons.noice.popupmenu.kind_icons.Struct,
          Text = icons.noice.popupmenu.kind_icons.Text,
          Unit = icons.noice.popupmenu.kind_icons.Unit,
          Value = icons.noice.popupmenu.kind_icons.Value,
          Variable = icons.noice.popupmenu.kind_icons.Variable,
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    ---@type LazyVimConfig
    opts = {
      -- icons used by other plugins
      icons = icons.lazyvim,
    },
  },
}
