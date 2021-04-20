nnoremap <silent> ? :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>gi :lua vim.lsp.buf.implementation()<CR>

lua << EOF
local lspconfig = require('lspconfig')
lspconfig.gopls.setup{}
lspconfig.tsserver.setup{}
lspconfig.jdtls.setup{
    cmd = { 'jdtls' },
    root_dir = lspconfig.util.root_pattern('pom.xml', 'gradle.build', '.git')
}
lspconfig.bashls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.clangd.setup{}
lspconfig.jsonls.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}
EOF

