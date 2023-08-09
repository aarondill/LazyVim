---Removes any non-ASCII characters, replacing with {rhs} or a space
---@param s string
---@param rhs? string
---@return string
local function sanitize(s, rhs)
  local r = string.gsub(s, "[\192-\255][\128-\191]*", rhs or " ")
  return r
end

return sanitize
