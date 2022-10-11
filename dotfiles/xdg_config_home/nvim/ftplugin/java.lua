local lspconfig = require("lspconfig")
local jdtls = require('jdtls')
local jdtls_setup = require("jdtls.setup")

local bundles = { vim.fn.glob("$HOME/repos/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar") }
vim.list_extend(bundles, vim.split(vim.fn.glob("$HOME/repos/microsoft/vscode-java-test/server/*.jar"), "\n"))
jdtls.start_or_attach({
  cmd = { 'jdtls' },
  root_dir = jdtls_setup.find_root({ '*.gradle', 'pom.xml' }),
  init_options = {
    bundles = bundles
  },
  settings = {
    java = {
      implementationsCodeLens = {
        enabled = true
      },
      completion = {
        importOrder = { }
      },
      sources = {
        organizeImports = {
          starThreshold = 3,
          staticStarThreshold = 3
        }
      },
      configuration = {
        -- Name is NOT arbitrary: must match one of the elements from `enum ExecutionEnvironment` in the link below
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        runtimes = {
          { name = "JavaSE-11", path = vim.fn.glob("$SDKMAN_DIR/candidates/java/11.*/") },
          { name = "JavaSE-17", path = vim.fn.glob("$SDKMAN_DIR/candidates/java/17.*/") },
        }
      }
    }
  },
  capabilities = lspconfig.util.default_config.capabilities,
  on_attach = function(client)
    jdtls_setup.add_commands()
    jdtls.update_project_config()
    jdtls.setup_dap({ hotcodereplace = 'auto' })
  end
})
