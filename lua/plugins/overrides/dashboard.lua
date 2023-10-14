local config_path = require("utils.config_path")
return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    opts = opts or {}
    -- Change the config button
    local action = "<cmd>execute 'Neotree " .. config_path() .. "' <bar> sleep 100m <bar>  e $MYVIMRC<CR>"
    for k, v in ipairs(opts.config.center) do
      if v.desc:find("^%s*Config$") then
        opts.config.center[k].action = action
        break
      end
    end
  end,
}
