if !isdirectory($HOME."/.config/nvim/undodir")
    call mkdir($HOME."/.config/nvim/undodir", "", 0770)
endif

if !isdirectory($HOME."/.config/nvim/backup")
    call mkdir($HOME."/.config/nvim/backup", "", 0770)
endif

if !isdirectory($HOME."/.config/nvim/swap")
    call mkdir($HOME."/.config/nvim/swap", "", 0770)
endif

set undofile undolevels=1000
set undodir=~/.config/nvim/undodir//


set nobackup writebackup
set backupdir=~/.config/nvim/backup//

set noswapfile

nnoremap U :echo " < < ===== C H E C K   C A P S   L O C K ===== > > "<CR>

autocmd BufWritePre /tmp/* setlocal noundofile
