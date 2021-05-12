nnoremap <silent> <C-j> :lnext<CR>
nnoremap <silent> <C-k> :lprevious<CR>
nnoremap <silent> ? :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>gi :lua vim.lsp.buf.implementation()<CR>

augroup load_diagnostics_into_localist
    autocmd!
    autocmd! BufWrite,BufEnter,InsertLeave * :lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
augroup END

hi LspDiagnosticsSignError guifg=#d75f5f
hi LspDiagnosticsSignWarning guifg=#f1fa8c
hi LspDiagnosticsSignInformation guifg=#87d7ff
hi LspDiagnosticsSignHint guifg=#eeeeee

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

lua << EOF
local lspconfig = require('lspconfig')
lspconfig.bashls.setup{}
lspconfig.clangd.setup{}
lspconfig.gopls.setup{}
lspconfig.jdtls.setup{ cmd = { 'jdtls' } }
lspconfig.jsonls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solargraph.setup{}
lspconfig.solargraph.setup{}
lspconfig.sqls.setup{}
lspconfig.sumneko_lua.setup {
  cmd = { "lua-language-server" };
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {
          "vim", -- vim
          "describe", "it", "before_each", "after_each", "teardown", "pending", "clear", -- Busted
        },
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
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
  }
)

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
EOF
