setlocal tabstop=4
setlocal colorcolumn=121

command! -buffer TestMethod lua require'jdtls'.test_nearest_method()
command! -buffer TestClass lua require'jdtls'.test_class()

" Load debug configuration after file update
autocmd BufWritePost <buffer> :lua pcall(require('jdtls.dap').setup_dap_main_class_configs)

lua << EOF
local lsp_config = require('eruizc.lsp')
local lspconfig = require("lspconfig")
local jdtls = require('jdtls')
local dap = require("dap")
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
        importOrder = {}
      },
      sources = {
        organizeImports = {
          starThreshold = 2,
          staticStarThreshold = 2
        }
      }
    }
  },
  capabilities = lspconfig.util.default_config.capabilities,
  on_attach = function(client)
    jdtls_setup.add_commands()
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    jdtls.update_project_config()
  end
})

dap.adapters.java = function(callback)
  util.execute_command({ command = 'vscode.java.startDebugSession' }, function(err0, port)
  assert(not err0, vim.inspect(err0))
  callback({
    type = 'server',
    host = '127.0.0.1',
    port = port,
  })
  end)
end
dap.configurations.java = { {
  type = 'java',
  request = 'attach',
  name = "Debug (Attach) - Remote",
  hostName = "127.0.0.1",
  port = 5005,
} }
EOF
