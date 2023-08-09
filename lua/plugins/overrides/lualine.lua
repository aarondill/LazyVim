local function wordcount()
  local wordcount_dict = vim.fn.wordcount()
  -- local mins = tostring(math.ceil(words / 200)) -- 200 wpm
  return string.format("%dw%dc", wordcount_dict.words, wordcount_dict.chars)
end

local function _get_current_lsp_for_each_client(client, buf_ft)
  local filetypes = client.config.filetypes
  if not filetypes or vim.fn.index(filetypes, buf_ft) == -1 then return end
  if not vim.lsp.buf_is_attached(0, client.id) then return end
  -- return client.name
  if client.name ~= "null-ls" then return client.name end

  -- Handle NullLS because it doesn't report its sources.
  local null_ls_active_sources = {}
  for _, source in ipairs(require("null-ls.sources").get_available(buf_ft)) do
    table.insert(null_ls_active_sources, source.name)
  end
  return string.format("%s[%s]", client.name, table.concat(null_ls_active_sources, ","))
end

local function get_current_lsp()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then return "No Lsp" end

  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local active_clients = {}
  for _, client in ipairs(clients) do
    local source = _get_current_lsp_for_each_client(client, buf_ft)
    if source then table.insert(active_clients, source) end
  end
  return table.concat(active_clients, ",")
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local lazyvim_icons = require("lazyvim.config").icons
    local lazyvim_util = require("lazyvim.util")

    return {
      extensions = { "neo-tree", "lazy", "fugitive", "man", "trouble" },
      options = {
        always_divide_middle = true,
        component_separators = {
          left = "|",
          right = "|",
        },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha" },
        },
        globalstatus = true,
        icons_enabled = true,
        ignore_focus = {},
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
        section_separators = {
          left = "",
          right = "",
        },
        theme = "auto",
      },
      sections = {
        -- LEFT SIDE:
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          -- Tabnine is added here later
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = lazyvim_icons.diagnostics.Error,
              warn = lazyvim_icons.diagnostics.Warn,
              info = lazyvim_icons.diagnostics.Info,
              hint = lazyvim_icons.diagnostics.Hint,
            },
          },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "󰌾 ", unnamed = "" }, separator = "-" },
          { "filetype" },
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            end,
          },
        },
        -- RIGHT SIDE:
        lualine_x = {
          -- Display keys as they're pressed
          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = lazyvim_util.fg("Statement"),
          },
          -- Display recording status (q)
          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = lazyvim_util.fg("Constant"),
          },
          -- Debug status
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = lazyvim_util.fg("Debug"),
          },
          -- Lazy.nvim update status
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = lazyvim_util.fg("Special"),
          },
          -- File information
          { "encoding" },
          { "fileformat" },
          { wordcount },
        },
        lualine_y = {
          { get_current_lsp },
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
    }
  end,
}