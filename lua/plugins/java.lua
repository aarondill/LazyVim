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
                  url = "~/vscode/Java/java-format.xml",
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
            callback = function()
              local jdtls = require("jdtls")
              local wk = require("which-key")
              local bufnr = vim.api.nvim_get_current_buf()

              local v_extract_variable = function()
                jdtls.extract_variable({ visual = true })
              end
              local v_extract_method = function()
                jdtls.extract_method({ visual = true })
              end

              wk.register({
                ["<leader>cJ"] = { name = "+java", buffer = bufnr, mode = { "n", "v" } },
              })

              wk.register({
                i = { jdtls.organize_importsorganize_imports, "Organize imports" },
                t = { jdtls.test_class, "Test class" },
                n = { jdtls.test_nearest_method, "Test nearest method" },
                e = { jdtls.extract_variable, "Extract variable" },
                M = { jdtls.extract_method, "Extract method" },
              }, {
                prefix = "<leader>cJ",
                buffer = bufnr,
              })

              wk.register({
                e = { v_extract_variable, "Extract variable" },
                M = { v_extract_method, "Extract method" },
              }, {
                mode = "v",
                prefix = "<leader>cJ",
                buffer = bufnr,
              })

              local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "package.json" }
              jdtls.start_or_attach(vim.tbl_extend("force", opts, {
                root_dir = require("jdtls.setup").find_root(root_markers),
              }))
              jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
            end,
          })

          return true
        end,
      },
    },
  },
}
