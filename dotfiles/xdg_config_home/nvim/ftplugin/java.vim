setlocal colorcolumn=121

command! -buffer TestMethod lua require'jdtls'.test_nearest_method()
command! -buffer TestClass lua require'jdtls'.test_class()
