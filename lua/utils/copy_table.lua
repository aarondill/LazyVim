---Local implementation of M.copy_table. Not meant for outside usage.
---@param obj table a table to copy
---@param seen table? a table to use for recursive checking
---@return table copied_table
local function copy_table(obj, seen)
  if type(obj) ~= "table" then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do
    res[copy_table(k, s)] = copy_table(v, s)
  end
  return res
end

---Deep copies a table. Avoid doing this for performance and memory reasons.
---@param obj table a table to copy
---@return table copied_table
return function(obj)
  return copy_table(obj)
end
