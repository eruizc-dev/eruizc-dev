setlocal tabstop=4
setlocal colorcolumn=121

lua require'jdtls'.start_or_attach(require('eruizc.lsp').get_jdtls_config())

noremap <buffer> <leader>a <cmd>lua require'jdtls'.code_action(true)<cr>
noremap <buffer> <leader>a <cmd>lua require'jdtls'.code_action(true)<cr>
