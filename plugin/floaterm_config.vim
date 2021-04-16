let g:floaterm_width=0.9
let g:floaterm_height=0.9

tnoremap <silent> <leader><esc> <C-\><C-n>:FloatermHide!<CR>

nnoremap <silent> <leader>1 :FloatermToggle term1<CR>
nnoremap <silent> <leader>2 :FloatermToggle term2<CR>
nnoremap <silent> <leader>3 :FloatermToggle term3<CR>
nnoremap <silent> <leader>4 :FloatermToggle term4<CR>
nnoremap <silent> <leader>5 :FloatermToggle term5<CR>

nnoremap <silent> <leader>lg :FloatermShowOrNew lazygit<CR>
nnoremap <silent> <leader>ld :FloatermShowOrNew lazydocker<CR>

" Maybe PR this into floaterm?
command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range
\   FloatermShowOrNew call floaterm_config#show_or_new(<bang>0, [visualmode(), <range>, <line1>, <line2>], <q-args>)

function! floaterm_config#show_or_new(bang, rangeargs, cmdargs)
    let [cmd, config] = floaterm#cmdline#parse(a:cmdargs)
    for bufnr in floaterm#buflist#gather()
        let title = getbufvar(bufnr, 'floaterm_title')
        if title == cmd
            call floaterm#terminal#open_existing(bufnr)
            return 0
        endif
    endfor
    call floaterm#run('new', a:bang, a:rangeargs, "--autoclose=2 --title=".cmd." ".a:cmdargs)
endfunction

command! Floaterms call floaterm_config#idk()
