function! health#dependencies#check() abort

    let files = [
    \   'tsc',
    \   'git', 'rg',
    \   'ranger',
    \   'lazygit', 'lazydocker',
    \   'solargraph', 'rubocop',
    \   'checkstyle'
    \]

    for file in files
        call health#dependencies#check_recheable(file)
    endfor

endfunction

function health#dependencies#check_recheable(file)
    if utils#file_reachable(a:file)
        call health#report_ok(a:file.' found')
    else
        call health#report_warn(
        \   a:file.' could not be found', [
        \       'make sure it is installed',
        \       'make sure it is in path or use absolute path instead',
        \])
    endif
endfunction
