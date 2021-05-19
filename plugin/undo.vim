if !isdirectory($HOME."/.config/nvim/undodir")
    call mkdir($HOME."/.config/nvim/undodir", "", 0770)
endif

set undofile undolevels=1000
set undodir=~/.config/nvim/undodir//

set nobackup nowritebackup
set noswapfile

autocmd BufWritePre /tmp/* setlocal noundofile
