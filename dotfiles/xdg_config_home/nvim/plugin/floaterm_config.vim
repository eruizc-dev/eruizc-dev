let g:floaterm_width=0.9
let g:floaterm_height=0.9

" Maybe PR this into floaterm?
" Ping tomle.zaku#6812 if you do, he's using this function too
command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range
\   FloatermTui call floaterm_config#floaterm_tui(<bang>0, [visualmode(), <range>, <line1>, <line2>], <q-args>)

function! floaterm_config#floaterm_tui(bang, rangeargs, cmdargs)
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

command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range
\   FloatermNewOrToggle call floaterm_config#floaterm_new_or_toggle(<bang>0, [visualmode(), <range>, <line1>, <line2>], <q-args>)

function! floaterm_config#floaterm_new_or_toggle(bang, rangeargs, cmdargs)
    let [cmd, config] = floaterm#cmdline#parse(a:cmdargs)
    for bufnr in floaterm#buflist#gather()
        let title = getbufvar(bufnr, 'floaterm_title')
        if title == config['title']
            call floaterm#terminal#open_existing(bufnr)
            return 0
        endif
    endfor
    call floaterm#run('new', a:bang, a:rangeargs, a:cmdargs)
endfunction

