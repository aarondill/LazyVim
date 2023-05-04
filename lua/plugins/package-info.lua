local function silent_normal(rhs, lhs)
  return { rhs, lhs, mode = "n", silent = true }
end
local is_tty = require("utils.is_tty")()
return {
  {
    "vuki656/package-info.nvim",
    opts = {
      icons = {
        enable = true, -- Whether to display icons
        style = {
          up_to_date = is_tty and "| " or "|  ", -- Icon for up to date dependencies
          outdated = is_tty and "X " or "|  ", -- Icon for outdated dependencies
        },
      },
      hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = "pnpm",
    },
    dependancies = { "MunifTanjim/nui.nvim", "nvim-telescope/telescope.nvim" },

    event = "BufEnter package.json",
    keys = {
      -- Show dependency versionjs
      silent_normal("<leader>ns", function()
        require("package-info").show()
      end),
      -- Delete dependency on the line
      silent_normal("<leader>nd", function()
        require("package-info").delete()
      end),
      -- Update dependency on the line
      silent_normal("<leader>nu", function()
        require("package-info").update()
      end),
      -- Install a different dependency version
      silent_normal("<leader>np", function()
        require("package-info").change_version()
      end),
      -- Install a new dependency
      silent_normal("<leader>ni", function()
        require("package-info").install()
      end),
    },
    config = function(_, opts)
      require("package-info").setup(opts)
      require("telescope").load_extension("package_info")

      -- Setup colors correctly
      local augroup = vim.api.nvim_create_augroup("package_info_augroup", { clear = true })
      vim.api.nvim_create_autocmd(
        "ColorScheme",
        { group = augroup, command = [[highlight PackageInfoOutdatedVersion guifg=red guibg=NONE]] }
      )
      vim.api.nvim_create_autocmd(
        "ColorScheme",
        { group = augroup, command = [[highlight PackageInfoUpToDateVersion guifg=green guibg=NONE]] }
      )
      vim.api.nvim_exec_autocmds("ColorScheme", { group = augroup })
    end,
  },
}
