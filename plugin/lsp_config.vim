nnoremap <silent> ? :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>gi :lua vim.lsp.buf.implementation()<CR>

lua << EOF
local lspconfig = require('lspconfig')
lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.gopls.setup{}
lspconfig.jdtls.setup{ cmd = { 'jdtls' } }
lspconfig.jsonls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}
lspconfig.solargraph.setup{}
lspconfig.sumneko_lua.setup {
  cmd = { "lua-language-server" };
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
  }
)
EOF

