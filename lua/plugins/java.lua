return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mfussenegger/nvim-jdtls", cond = not vim.o.diff },
    },
    opts = {
      ---@type lspconfig.options
      servers = {
        jdtls = {
          on_attach = function()
            require("jdtls.setup").add_commands()
          end,
          cmd = { "jdtls" },
          settings = {
            java = {},
          },
        },
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        jdtls = function(server, opts)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              local jdtls = require("jdtls")
              local wk = require("which-key")
              local bufnr = vim.api.nvim_get_current_buf()

              local extract_variable = function()
                jdtls.extract_variable(true)
              end
              local extract_method = function()
                jdtls.extract_method(true)
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
                e = { extract_variable, "Extract variable" },
                M = { extract_method, "Extract method" },
              }, {
                mode = "v",
                prefix = "<leader>cJ",
                buffer = bufnr,
              })

              local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "package.json" }
              jdtls.start_or_attach(vim.tbl_extend("force", opts, {
                root_dir = require("jdtls.setup").find_root(root_markers),
              }))
              jdtls.setup_dap({ hotcodereplace = "auto" })
            end,
          })

          return true
        end,
      },
    },
  },
}
