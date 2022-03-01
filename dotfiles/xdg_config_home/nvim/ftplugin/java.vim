setlocal tabstop=4
setlocal colorcolumn=121

command! -buffer TestMethod lua require'jdtls'.test_nearest_method()
command! -buffer TestClass lua require'jdtls'.test_class()

" Load debug configuration after file update
autocmd BufWritePost <buffer> :lua pcall(require('jdtls.dap').setup_dap_main_class_configs)

lua << EOF
local lsp_config = require('eruizc.lsp')
local jdtls = require('jdtls')
local dap = require("dap")

jdtls.start_or_attach(lsp_config.get_jdtls_config())

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
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  }
}
EOF
