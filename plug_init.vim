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
Plug 'dikiaap/minimalist'           " Better than gruvbox
Plug 'vim-airline/vim-airline'

" Utilities
Plug 'kristijanhusak/vim-dadbod-ui'     " God bless tpope and kristijanhusak
Plug 'mbbill/undotree'                  " I don't want to know what my life would be without this
Plug 'nvim-telescope/telescope.nvim'    " God bles TJ
Plug 'preservim/nerdtree'               " Cooler than I originally thought

" Functional
Plug 'neovim/nvim-lspconfig'    " Bring me the language serversss
Plug 'hrsh7th/nvim-compe'       " Best completion
Plug 'RishabhRD/nvim-lsputils'  " Do I even use this?
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " It makes my code look pretty

" Language specific
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Plugins for plugins
Plug 'ryanoasis/vim-devicons'       " nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'  " nerdtree
Plug 'kyazdani42/nvim-web-devicons' " telescope

call plug#end()
