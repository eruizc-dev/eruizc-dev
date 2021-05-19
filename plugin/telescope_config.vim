nnoremap <Leader>p :lua require'eruizc.telescope'.find_sources()<cr>
nnoremap <Leader>t :lua require'eruizc.telescope'.find_tests()<cr>
nnoremap <leader>P <cmd>Telescope live_grep<cr>
nnoremap <leader>config <cmd>lua require("eruizc.telescope").vimrc()<cr>

nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
