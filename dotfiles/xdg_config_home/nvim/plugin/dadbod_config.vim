if filereadable(expand("$HOME/.config/nvim/secrets.vim"))
    source ~/.config/nvim/secrets.vim
    if !empty(b:dadbod_databases)
        let g:dbs = b:dadbod_databases
     endif
endif

let g:db_ui_use_nerd_fonts = 1
let g:db_ui_table_helpers = {
\   'sqlserver': {
\     'Count': 'select count(*) from [{table}]'
\   }
\ }
