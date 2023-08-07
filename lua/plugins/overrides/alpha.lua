local config_path = require("utils.config_path")
local deep_get = require("utils.deep_get")
return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    -- Import the util functions from alpha
    local dashboard = require("alpha.themes.dashboard")
    -- Setup my custom button
    local config_button = dashboard.button(
      "c",
      "  Config",
      -- Sleeps to wait for Neotree and ensure that vimrc is focused
      "<cmd>execute 'Neotree "
        .. config_path()
        .. "' <bar> sleep 100m <bar>  e $MYVIMRC<CR>"
    )

    -- Replace the 5th button with my custom button
    opts.section.buttons.val[5] = config_button
    -- Set up highlight groups to match the first button (or defaults)
    local first_button = deep_get(opts, "section", "buttons", "val", 1)
    config_button.opts.hl = deep_get(first_button, "opts", "hl") or "AlphaButtons"
    config_button.opts.hl_shortcut = deep_get(first_button, "opts", "hl_shortcut") or "AlphaShortcut"
  end,
}
