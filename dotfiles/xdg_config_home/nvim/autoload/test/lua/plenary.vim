function! test#lua#plenary#test_file(file)
    return a:file =~# g:test#lua#busted#file_pattern
endfunction

function! test#lua#plenary#build_position(type, position)
    if a:type ==# "nearest" || a:type ==# "file"
        return ["--headless", "-c 'PlenaryBustedFile ".a:position["file"]."'"]
    else
        if filereadable("lua")
            return ["--headless", '-c "PlenaryBustedDirectory ./lua"']
        else
            return ["--headless", '-c "PlenaryBustedDirectory ."']
        endif
    endif
endfunction

function! test#lua#plenary#build_args(args)
    return a:args
endfunction

function! test#lua#plenary#executable()
    return "nvim"
endfunction

