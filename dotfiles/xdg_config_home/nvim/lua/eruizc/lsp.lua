local lspconfig = require("lspconfig")
local utils = require("eruizc.utils")
local lsputil = require("lsputil.codeAction")

local checkstyle = {
  lintCommand = "java -jar /usr/local/lib/checkstyle/checkstyle-8.39-all.jar -c checkstyle.xml ${INPUT}",
  lintFormats = { "[ERROR] %f:%l:%c: %m" },
  lintStdin = true,
  lintIgnoreExitCode = true,
}

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.efm.setup {
  autostart = false,
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
lspconfig.jdtls.setup{
  cmd = { "jdtls" },
  root_dir = function(f)
    return lspconfig.util.root_pattern('pom.xml', 'gradle.build', '.git')(f) or vim.fn.getcwd()
  end
}
lspconfig.jsonls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.sumneko_lua.setup{
  cmd = { "lua-language-server" };
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
