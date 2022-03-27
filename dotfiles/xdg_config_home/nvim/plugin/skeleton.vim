if exists('g:skeleton_loaded') || &compatible
    finish
else
    let g:skeleton_loaded = v:true
endif

function! skeleton#insert()
    let filename = expand('%:t')
    let filetype = expand('%:e')

    let fileSkeleton = expand('~/.config/nvim/skeleton/'.filename)
    if len(fileSkeleton) > 0 && filereadable(fileSkeleton)
        execute '0r '.fileSkeleton
        return
    endif

    let templateSkeleton = expand('~/.config/nvim/skeleton/template.'.filetype)
    if len(templateSkeleton) > 0 && filereadable(templateSkeleton)
        execute '0r '.templateSkeleton
    endif
endfunction

augroup load_skeleton
    au!
    autocmd BufNewFile * silent call skeleton#insert()
augroup END
