local dap = require("dap")
local util = require("jdtls.util")

vim.g.dap_virtual_text = true

dap.adapters.java = function(callback)
  util.execute_command({command = 'vscode.java.startDebugSession'}, function(err0, port)
    assert(not err0, vim.inspect(err0))
    callback({
      type = 'server';
      host = '127.0.0.1';
      port = port;
    })
  end)
end
dap.adapters.lldb = {
  type = "executable",
  command = "lldb-vscode",
  name = "lldb"
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = false,
  },
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}
dap.configurations.rust = dap.configurations.cpp

local util = require('jdtls.util')

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Java attach",
    hostName = "127.0.0.1",
    port = 5005
  },
}

