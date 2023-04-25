---returns a curried function that represents f(args, other_args)
---@generic args, rest, return
---@param f fun(args, rest): return
---@param ... args
---@return fun(rest): return
return function(f, ...)
  local args = { ... }
  return function(...)
    for _, v in ipairs({ ... }) do
      table.insert(args, v)
    end
    return f(unpack(args))
  end
end
