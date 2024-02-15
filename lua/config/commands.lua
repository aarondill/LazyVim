-- Setup user commands here. This is loaded by init.lua

vim.api.nvim_create_user_command("DiffSaved", require("utils.diff_with_saved"), {})
vim.api.nvim_create_user_command("RandomLine", function()
  local l = math.random(1, vim.fn.line("$") or 1) -- Get random number upto last line
  vim.cmd("normal! " .. l .. "G")
end, {})

local nvim_cmd = vim.api.nvim_cmd ---@type fun(cmd:vim.api.keyset.cmd, opts:vim.api.keyset.cmd_opts): string

vim.api.nvim_create_user_command("UniqLines", function()
  -- Source: https://vim.fandom.com/wiki/Uniq_-_Removing_duplicate_lines
  local patterns = { [[/^\(.*\)\(\n\1\)\+$/\1/]], [[/\v^(.*)(\n\1)+$/\1/]] }
  for _, p in ipairs(patterns) do
    pcall(nvim_cmd, {
      args = { p },
      cmd = "substitute",
      range = { 1, vim.fn.line("$") },
    }, {})
  end
end, {})

local function loop(client)
  if client.name == "null-ls" then return end
  local capAsList = {}
  for key, value in pairs(client.server_capabilities) do
    if value and key:find("Provider") then
      local capability = key:gsub("Provider$", "")
      table.insert(capAsList, capability)
    end
  end
  table.sort(capAsList) -- sorts alphabetically

  local msg = ("# %s\n%s"):format(client.name, table.concat(capAsList, "\n"))
  vim.notify(msg, vim.log.levels.INFO, { timeout = 14 * 1000 })
end
vim.api.nvim_create_user_command("LspCapabilities", function()
  local curBuf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = curBuf })
  vim.tbl_map(loop, clients)
end, {})

vim.api.nvim_create_user_command("OrganizeImports", function()
  local tsserver_is_attached = next(vim.lsp.get_clients({ bufnr = 0, name = "tsserver" })) ~= nil
  return vim.lsp.buf.execute_command({
    command = tsserver_is_attached and "_typescript.organizeImports" or "source.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  })
end, {})
