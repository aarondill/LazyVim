local function silent_normal(rhs, lhs, desc)
  return { rhs, lhs, mode = "n", silent = true, desc = desc }
end
return {
  {
    "vuki656/package-info.nvim",
    opts = {
      icons = { enable = true },
      hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = "pnpm",
    },
    dependencies = { "MunifTanjim/nui.nvim", "nvim-telescope/telescope.nvim" },

    event = {
      -- "BufEnter package.json",
      "BufReadPre package.json",
      "BufNewFile package.json",
    },
    keys = {
      -- Show dependency versionjs
      silent_normal("<leader>ns", function()
        require("package-info").show()
      end, "Show package versions"),
      -- Delete dependency on the line
      silent_normal("<leader>nd", function()
        require("package-info").delete()
      end, "Delete dependency"),
      -- Update dependency on the line
      silent_normal("<leader>nu", function()
        require("package-info").update()
      end, "Update dependency"),
      -- Install a different dependency version
      silent_normal("<leader>np", function()
        require("package-info").change_version()
      end, "Change dependency version"),
      -- Install a new dependency
      silent_normal("<leader>ni", function()
        require("package-info").install()
      end, "Install dependency"),
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
