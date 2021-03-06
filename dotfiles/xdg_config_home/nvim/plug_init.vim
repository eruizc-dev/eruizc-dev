" Stolen from BEGINBOT (https://github.com/davidbegin/beginfiles/blob/master/nvim/plug_init.vim)

if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading plugin manager..."
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin("~/.config/nvim/plugged")

" Utils
Plug 'RishabhRD/popfix'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'tpope/vim-sensible'

" Must have
Plug 'editorconfig/editorconfig-vim'
Plug 'eruizc-dev/vim-flex'				" Arch BTW
Plug 'mbbill/undotree'
Plug 'troydm/zoomwintab.vim'

" Visuals
Plug 'dikiaap/minimalist'           " Better than gruvbox
Plug 'eruizc-dev/galaxyline.nvim', { 'branch': 'merge-all' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Git
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'

" Database
Plug 'tpope/vim-dadbod'         			" God bless tpope
Plug 'kristijanhusak/vim-dadbod-ui'     	" God bless kristijanhusak
Plug 'kristijanhusak/vim-dadbod-completion'

" LSP and completion
Plug 'RishabhRD/nvim-lsputils'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/symbols-outline.nvim'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'ray-x/lsp_signature.nvim'

" Utilities
Plug 'eruizc-dev/rubberduck.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'    " God bles TJ
Plug 'vim-test/vim-test'
Plug 'voldikss/vim-floaterm'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'kristijanhusak/orgmode.nvim'

" Language specific
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
Plug 'mfussenegger/nvim-jdtls'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'

call plug#end()
