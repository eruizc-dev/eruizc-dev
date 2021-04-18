" autocmd FileType java lua require'java_config'
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
EOF

" Action mapping
nnoremap <silent> ?? :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<CR>

" Gotos, better in telescope
" nnoremap <silent> <leader>gd :lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <leader>gi :lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <leader>gr :lua vim.lsp.buf.references()<CR>
" nnoremap <silent> <leader>gD :lua vim.lsp.buf.declaration()<CR>

" And below some things not currently in my workflow

" Gotos
" nnoremap <silent> <leader>gs :lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <leader>gt :lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> <leader>gw :lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> <leader>gW :lua vim.lsp.buf.workspace_symbol()<CR>

" Few language severs support these three
" nmap <leader>= :lua vim.lsp.buf.formatting()<CR>
" nmap <leader>ai :lua vim.lsp.buf.incoming_calls()<CR>
" nmap <leader>ao :lua vim.lsp.buf.outgoing_calls()<CR>

" Diagnostics mapping
" nmap <leader>ee  :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
" nmap <leader>en  :lua vim.lsp.diagnostic.goto_next()<CR>
" nmap <leader>ep  :lua vim.lsp.diagnostic.goto_prev()<CR>
