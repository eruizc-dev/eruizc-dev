require('lspconfig').gopls.setup {
    cmd = {'gopls', 'serve'},
    settings = {
        gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
        }
    }
}
