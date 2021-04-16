source secrets.vim

let g:db_ui_use_nerd_fonts = 1
let g:dbs = b:dadbod_databases
let g:db_ui_table_helpers = {
\   'sqlserver': {
\     'Count': 'select count(*) from [{table}]'
\   }
\ }
