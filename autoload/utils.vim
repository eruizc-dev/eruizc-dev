function utils#file_reachable(file)
        if filereadable(expand(a:file))
            return v:true
        else
            return utils#exist_in_path(a:file)
        endif

endfunction

function utils#exist_in_path(file)
    let path = expand('$PATH')
    let dirs = split(path, ':')

    for dir in dirs
        if filereadable(dir.'/'.a:file)
            return v:true
        endif
    endfor
    return v:false
endfunction
