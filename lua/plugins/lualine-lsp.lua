local function get_null_ls_sources(ft)
  local sources = {}
  for _, source in ipairs(require("null-ls.sources").get_available(ft)) do
    table.insert(sources, source.name)
  end
  return sources
end

local function get_current_lsp()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then return "No Lsp" end

  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local active_clients = {}
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      if vim.lsp.buf_is_attached(0, client.id) then
        -- return client.name
        if client.name == "null-ls" then
          local source_str = table.concat(get_null_ls_sources(buf_ft), ",")
          table.insert(active_clients, client.name .. "[" .. source_str .. "]")
        else
          table.insert(active_clients, client.name)
        end
      end
    end
  end

  return table.concat(active_clients, ",")
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- vim.notify(vim.inspect(opts.sections.lualine_x))
    table.insert(opts.sections.lualine_y, 1, { get_current_lsp })
  end,
}
