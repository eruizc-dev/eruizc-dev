local lspconfig = require("lspconfig")
local utils = require("eruizc.utils")

lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.gopls.setup{}
lspconfig.jdtls.setup{ cmd = { "jdtls" } }
lspconfig.jsonls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.solargraph.setup{}
lspconfig.sqls.setup{}
lspconfig.sumneko_lua.setup{
  cmd = { "lua-language-server" };
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", },
      diagnostics = {
        enable = true,
        disable = { "trailing-space", },
        globals = { "vim", "describe", "it", "before_each", "after_each", "teardown", "pending", "clear", },
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

vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})
