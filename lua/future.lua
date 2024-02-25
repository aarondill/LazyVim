-- Fowards compatability:
table.pack = table.pack or function(...) return { n = select("#", ...), ... } end
table.unpack = table.unpack or unpack
vim.uv = vim.uv or vim.loop
---@param ... string
---@return string
vim.fs = vim.fs or function(...) return (table.concat({ ... }, "/"):gsub("//+", "/")) end
