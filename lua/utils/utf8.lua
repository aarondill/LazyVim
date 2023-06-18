local M = {}

---Loads the utf8 module, throwing a nice error message if it fails
---@return table
local function load_utf8_module()
  local _G_utf8 = rawget(_G, "utf8")
  -- stylua: ignore
  if _G_utf8 then return _G_utf8 end

  local ok, utf8 = pcall(require, "utf8")
  if not ok then
    error([[ utf8.nvim module must be loaded before using this!]])
  end
  return utf8
end
---Removes any non-ASCII characters, replacing with {rhs} or a space
---@param s string
---@param rhs? string
---@return string
function M.sanitize(s, rhs)
  local r = string.gsub(s, "[\192-\255][\128-\191]*", rhs or " ")
  return r
end

---string.sub but with utf8 support
---@param s string
---@param i? integer start of new string [1]
---@param j? integer end of new string [#s]
---@return string|nil sub
---@see string.sub
---@source http://lua-users.org/lists/lua-l/2014-04/msg00590.html
function M.sub(s, i, j)
  local utf8 = load_utf8_module()
  i = i or 1
  j = j or -1
  if i < 1 or j < 1 then
    local n = utf8.len(s)
    if not n then
      return nil
    end
    if i < 0 then
      i = n + 1 + i
    end
    if j < 0 then
      j = n + 1 + j
    end
    if i < 0 then
      i = 1
    elseif i > n then
      i = n
    end
    if j < 0 then
      j = 1
    elseif j > n then
      j = n
    end
  end
  if j < i then
    return ""
  end
  i = utf8.offset(s, i)
  j = utf8.offset(s, j + 1)
  if i and j then
    return s:sub(i, j - 1)
  elseif i then
    return s:sub(i)
  else
    return ""
  end
end

-- Allow outside code to access the utf8 module directly on the export table
setmetatable(M, {
  __index = function(t, k)
    return rawget(t, k) or rawget(load_utf8_module(), k)
  end,
})

return M
