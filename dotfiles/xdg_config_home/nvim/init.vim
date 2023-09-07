let mapleader=' '

" Quality of life
set ignorecase smartcase
set incsearch hlsearch
set splitright splitbelow
set noerrorbells
set number relativenumber
set nowrap
set scrolloff=4
set tabstop=2 softtabstop=0 shiftwidth=0 smartindent
set inccommand=nosplit

" Menu
set showcmd
set confirm

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
