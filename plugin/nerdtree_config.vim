nnoremap <silent> <C-p> :NERDTreeToggle<CR>

" Nerdtree on all tabs
autocmd BufWinEnter * silent NERDTreeMirror

" Exit nerdtree on file open
let NERDTreeQuitOnOpen=v:true

let NERDTreeShowHidden=v:true
