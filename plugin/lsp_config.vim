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

