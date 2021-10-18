setlocal tabstop=4
setlocal colorcolumn=121

lua require'jdtls'.start_or_attach(require('eruizc.lsp').get_jdtls_config())

nnoremap <buffer> <leader>a <cmd>lua require'jdtls'.code_action()<cr>
vnoremap <buffer> <leader>a <cmd>lua require'jdtls'.code_action(true)<cr><esc> " Esc is used because the selection goes to the popup

command! -buffer TestMethod lua require'jdtls'.test_nearest_method()
command! -buffer TestClass lua require'jdtls'.test_class()

" Load debug configuration after file update
autocmd BufWritePost <buffer> :lua pcall(require('jdtls.dap').setup_dap_main_class_configs)
