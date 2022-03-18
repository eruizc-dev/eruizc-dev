setlocal colorcolumn=121

command! -buffer TestMethod lua require'jdtls'.test_nearest_method()
command! -buffer TestClass lua require'jdtls'.test_class()

" Load debug configuration after file update
autocmd BufWritePost <buffer> :lua pcall(require('jdtls.dap').setup_dap_main_class_configs)
