if exists('g:filetypes_loaded') || &compatible
    finish
endif
let g:filetypes_loaded = v:true

augroup filetypedetect
    au BufRead,BufNewFile .babelrc      setfiletype json
    au BufRead,BufNewFile .firebaserc   setfiletype json
augroup END

