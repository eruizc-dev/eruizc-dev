" Stolen from BEGINBOT (https://github.com/davidbegin/beginfiles/blob/master/nvim/plug_init.vim)

if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading plugin manager..."
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin("~/.config/nvim/plugged")

" Must have
Plug 'tpope/vim-sensible'   " God bless tpope
Plug 'eruizc-dev/vim-flex'  " Because I use Arch BTW

" Dependencies
Plug 'nvim-lua/popup.nvim'      " plenary
Plug 'nvim-lua/plenary.nvim'    " telescope
Plug 'tpope/vim-dadbod'         " vim-dadbod-ui (God bless tpope)
Plug 'RishabhRD/popfix'         " nvim-lsputils

" QOL
Plug 'editorconfig/editorconfig-vim'
Plug 'troydm/zoomwintab.vim'
Plug 'voldikss/vim-floaterm'

" Visuals
Plug 'Xuyuanp/nerdtree-git-plugin'  " nerdtree
Plug 'dikiaap/minimalist'           " Better than gruvbox
Plug 'kyazdani42/nvim-web-devicons' " telescope
Plug 'ryanoasis/vim-devicons'       " nerdtree
Plug 'eruizc-dev/galaxyline.nvim', { 'branch': 'merge-all' }

" Utilities
Plug 'RishabhRD/nvim-lsputils'  " Do I even use this?
Plug 'kristijanhusak/vim-dadbod-ui'     " God bless tpope and kristijanhusak
Plug 'mbbill/undotree'                  " I don't want to know what my life would be without this
Plug 'nvim-telescope/telescope.nvim'    " God bles TJ
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " telescope
Plug 'preservim/nerdtree'               " Cooler than I originally thought
Plug 'simrat39/symbols-outline.nvim'
Plug 'vim-test/vim-test'

" Functional
Plug 'neovim/nvim-lspconfig'    " Bring me the language serversss
Plug 'hrsh7th/nvim-compe'       " Best completion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " It makes my code look pretty

" Language specific
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Testing
Plug 'rhysd/git-messenger.vim'

" Mine
Plug 'eruizc-dev/rubberduck.nvim'

call plug#end()

