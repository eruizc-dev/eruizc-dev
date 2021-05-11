" Load plugins, stolen from BEGINBOT (https://github.com/davidbegin/beginfiles/blob/c72ef20f9c613528af9f7b34be8d03093ad0d873/nvim/init.vim#L9)
source $HOME/.config/nvim/plug_init.vim

" Residual files
if !isdirectory($HOME."/.config/nvim/undodir")
    call mkdir($HOME."/.config/nvim/undodir", "", 0770)
endif
set undofile undodir=~/.config/nvim/undodir//
set nobackup
set noswapfile

" Quality of life
let mapleader=' '
set exrc
set ignorecase smartcase
set incsearch hlsearch
set splitright splitbelow
set noerrorbells
set number relativenumber
set nowrap
set expandtab tabstop=4 softtabstop=0 shiftwidth=0 smartindent

" Visuals
syntax on
set t_Co=256
set termguicolors
colorscheme minimalist
set showmatch
set cursorline
set guicursor=
hi CursorLine cterm=bold

" Menu
set showcmd
set confirm

" Autocomplete
inoremap <silent> <C-j> <C-n>
inoremap <silent> <C-k> <C-p>

" File navigation

" nnoremap <silent> <C-j> Still unused
" nnoremap <silent> <C-k> Still unused
nnoremap <silent> <C-h> <C-o>
nnoremap <silent> <C-l> <C-i>

" Workaroud for this https://github.com/hrsh7th/nvim-compe/issues/286
let g:omni_sql_default_compl_type = 'syntax'

lua require("eruizc")
