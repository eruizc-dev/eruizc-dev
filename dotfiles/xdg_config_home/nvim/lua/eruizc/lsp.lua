local lspconfig = require("lspconfig")
local utils = require("eruizc.utils")
local lsputil = require("lsputil.codeAction")

local checkstyle = {
  lintCommand = "java -jar /usr/local/lib/checkstyle/checkstyle-8.39-all.jar -c checkstyle.xml ${INPUT}",
  lintFormats = { "[ERROR] %f:%l:%c: %m" },
  lintIgnoreExitCode = true,
}

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.cssls.setup{
  root_dir = function(f)
    return lspconfig.util.root_pattern("package.json", ".git")(f) or vim.fn.getcwd()
  end
}
lspconfig.efm.setup {
  filetypes = { "java" },
  on_attach = function(client)
    client.resolved_capabilities.rename = false
    client.resolved_capabilities.hover = false
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.completion = false
  end,
  root_dir = function() return vim.fn.getcwd() end,
  settings = {
    rootMarkers = { "checkstyle.xml" },
    languages = {
      java = { checkstyle },
    }
  },
}
lspconfig.gopls.setup{}
lspconfig.html.setup{
  root_dir = function() return vim.fn.getcwd() end
}
lspconfig.jdtls.setup{
  cmd = { "jdtls" },
  root_dir = function(f)
    return lspconfig.util.root_pattern('pom.xml', 'gradle.build', '.git')(f) or vim.fn.getcwd()
  end,
  settings = {
    java = {
      implementationsCodeLens = {
        enabled = true
      },
      completion = {
        importOrder = {}
      }
    }
  }
}
lspconfig.jsonls.setup{
  root_dir = function() return vim.fn.getcwd() end
}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.sumneko_lua.setup{
  cmd = { "lua-language-server" };
  root_dir = function(fname)
    local nvim_dir = lspconfig.util.root_pattern('lua')(fname)
    if nvim_dir then return nvim_dir..'/lua' end
    return lspconfig.util.root_pattern('rc.lua', 'init.lua', 'init.vim', '.git')(fname) or vim.fn.getcwd()
  end,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", },
      diagnostics = {
        enable = true,
        disable = { "trailing-space", },
        globals = {
          -- Neovim
          "vim",
          -- Awesome
          "awesome", "client", "root", "screen",
          -- Busted
          "describe", "it", "before_each", "after_each", "teardown", "pending", "clear"
        },
      },
      workspace = {
        library = utils.get_lua_runtime(),
        maxPreload = 1024,
        preloadFileSize = 1024,
      },
    },
  },
}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}

vim.lsp.handlers["textDocument/codeAction"] = lsputil.code_action_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  virtual_text = false,
})
