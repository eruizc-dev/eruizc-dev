"""THE BASICS"""
let mapleader=' '

"""BETTER DEFAULTS"""
nnoremap ZZ :echo"<< ===== C H E C K   C A P S   L O C K ===== >>"<cr>
vnoremap  J   :m '>+1<cr>gv=gv
vnoremap  K   :m '<-2<cr>gv=gv
vnoremap  <   <gv
vnoremap  >   >gv
nnoremap  Y   y$
nnoremap  +   <C-a>
nnoremap  -   <C-x>
vnoremap  +   <C-a>
vnoremap  -   <C-x>
vnoremap  g+  g<C-a>
vnoremap  g-  g<C-x>
nnoremap  gf  gF

"""UNDO"""
nnoremap	U		<C-r>
inoremap	,		,<c-g>u
inoremap 	. 	.<c-g>u
inoremap 	; 	;<c-g>u

"""TERMINALS"""
tnoremap  <C-o>	<C-\><C-n>

"""QUALITY OF LIFE"""
set ignorecase smartcase
set incsearch hlsearch
set splitright splitbelow
set noerrorbells
set number relativenumber
set nowrap
set scrolloff=4
set expandtab tabstop=4 softtabstop=0 shiftwidth=0 smartindent
set inccommand=nosplit
set noswapfile

"""" MENU STUFF"""
set showcmd
set confirm
set wildcharm=<Tab>
cnoremap <C-j> <Tab>
cnoremap <C-k> <Tab><S-Tab><S-Tab>
cnoremap <C-h> <up>
cnoremap <C-l> <down>

" Styling
set termguicolors
set cursorline
set guicursor=

augroup auto_mkdir_new_file
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || input("Do you want to create directory '" . a:dir . "'? y/N: ") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

" TODO: Push to upstream
au! BufRead,BufNewFile *.conf setfiletype conf
au! BufRead,BufNewFile *.njk setfiletype html
au! BufRead,BufNewFile flake.lock setfiletype json

try
	lua require 'eruizc-dev'
catch
	echo 'Failed to load lua configs, using defaults'
	colorscheme slate
endtry
