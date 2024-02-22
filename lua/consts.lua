local M = {}
---@type table<string, boolean>
M.ignored_filetypes = {
  "",
  "TelescopePrompt",
  "TelescopeResults",
  "alpha",
  "dashboard",
  "help",
  "lazy",
  "lspinfo",
  "mason",
  "neo-tree",
  "nvcheatsheet",
  "nvdash",
  "starter",
  "terminal",
}
M.root_markers = {
  ".git",
  ".github",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
  "package.json",
  "lua/",
  "Makefile",
  "Makefile.am",
}
---@type LazyRootSpec[]
M.lazy_root_spec = { "lsp", M.root_markers, "cwd" }

return M
