local function setup_jdtls(opts)
  local jdtls = require("jdtls")
  local consts = require("consts")
  local bufnr = vim.api.nvim_get_current_buf()

  local has_wk, wk = pcall(require, "which-key")
  if has_wk then wk.register({
    ["<leader>cJ"] = { name = "+java", buffer = bufnr, mode = { "n", "v" } },
  }) end

  local root_dir = require("jdtls.setup").find_root(consts.root_markers)

  -- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
  local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
  local cachedir = vim.fn.stdpath("cache")
  assert(type(cachedir) == "string")
  local workspace_dir = vim.fs.joinpath(cachedir, "jdtls", "workspace", project_name)

  local config = vim.tbl_extend("force", opts, { root_dir = root_dir })
  vim.list_extend(config.cmd, { "-data", workspace_dir })
  jdtls.start_or_attach(config)
  -- DAP is available? set it up.
  if pcall(require, "dap") then jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} }) end
end

---Loads all matches to the quickfix list then opens a telescope picker
---@param result lsp.TypeHierarchyItem[]|nil
---@param ctx {params: {item: lsp.TypeHierarchyItem}}
local function telescope_hierarchy(_, result, ctx)
  if not result then return end
  table.insert(result, 1, ctx.params.item) -- insert the given item at the start of the list
  vim.ui.select(result, {
    ---@return string
    format_item = function(item) ---@param item lsp.TypeHierarchyItem
      local kind = vim.lsp.protocol.SymbolKind[item.kind] or "Unknown"
      return item.name .. " [" .. kind .. "]"
    end,
    prompt = "Select to open:",
  }, function(item) ---@param item lsp.TypeHierarchyItem
    item.range = item.selectionRange -- We prefer to jump at the selectionRange
    vim.lsp.util.jump_to_location(item, "utf-8", true)
  end)
end

local function type_hierarchy(method, handler)
  local params = vim.lsp.util.make_position_params()
  local prepare_method = "textDocument/prepareTypeHierarchy"
  vim.lsp.buf_request(0, prepare_method, params, function(_, result)
    if not result then return end
    vim.lsp.buf_request(0, method, { item = result[1] }, handler)
  end)
end

---@param method string
local function lazy_method(method, ...)
  local args = select("#", ...) > 0 and vim.F.pack_len(...) or nil
  return function()
    if not args then return require("jdtls")[method]() end
    return require("jdtls")[method](unpack(args, 1, args.n))
  end
end
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mfussenegger/nvim-jdtls", cond = not vim.o.diff },
    },
    opts = {
      ---@type lspconfig.options | {}
      servers = {
        jdtls = {
          ---@type LazyKeysSpec[]
          keys = {
            {
              "<leader>cJh",
              function() return type_hierarchy("typeHierarchy/supertypes", telescope_hierarchy) end,
              desc = "Show Class Hierarchy",
            },
            { "<leader>cJi", lazy_method("organize_imports"), desc = "Organize imports" },
            { "<leader>cJt", lazy_method("test_class"), desc = "Test class" },
            { "<leader>cJn", lazy_method("test_nearest_method"), desc = "Test nearest method" },
            { "<leader>cJe", lazy_method("extract_variable"), desc = "Extract variable" },
            { "<leader>cJM", lazy_method("extract_method"), desc = "Extract method" },
            {
              "<leader>cJe",
              lazy_method("extract_variable", { visual = true }),
              desc = "Extract variable",
              mode = "v",
            },
            { "<leader>cJM", lazy_method("extract_method", { visual = true }), desc = "Extract method", mode = "v" },
          },
          cmd = { "jdtls" },
          settings = {
            redhat = {
              telemetry = { enabled = false },
            },
            java = {
              home = nil, ---@type nil This is FINE!
              format = {
                enabled = true,
                comments = { enabled = true },
                onType = { enabled = false },
                settings = {
                  url = "~/code/java/java-format.xml",
                  profile = nil, ---@type nil - the config is defined above
                },
              },
            },
          },
        },
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        jdtls = function(_, opts)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function() return setup_jdtls(opts) end,
          })
          return true
        end,
      },
    },
  },
}
