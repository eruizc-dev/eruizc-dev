"""ESSENTIALS"""
set termguicolors
set cursorline
set guicursor=

"""THEME MODIFICATION"""
colorscheme minimalist
hi CursorLine cterm=bold
hi Normal ctermbg=none guibg=none
hi NonText ctermbg=none guibg=none
hi EndOfBuffer ctermbg=none guibg=none

"""LSP HIGHLIGHTING"""
hi LspDiagnosticsSignError guifg=#d75f5f
hi LspDiagnosticsDefaultError guifg=#d75f5f
sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError

hi LspDiagnosticsSignWarning guifg=#f1fa8c
hi LspDiagnosticsDefaultWarning guifg=#f1fa8c
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning

hi LspDiagnosticsSignInformation guifg=#87d7ff
hi LspDiagnosticsDefaultInformation guifg=#87d7ff
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation

hi LspDiagnosticsSignHint guifg=#eeeeee
hi LspDiagnosticsDefaultHint guifg=#eeeeee
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint
