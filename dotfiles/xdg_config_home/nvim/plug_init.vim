" Stolen from BEGINBOT (https://github.com/davidbegin/beginfiles/blob/master/nvim/plug_init.vim)

if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading plugin manager..."
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > ~/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin("~/.config/nvim/plugged")

" Libraries / Dependencies
Plug 'RishabhRD/popfix'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'tpope/vim-sensible'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'MunifTanjim/nui.nvim'

" QOL
Plug 'editorconfig/editorconfig-vim'
Plug 'mbbill/undotree'
Plug 'troydm/zoomwintab.vim'
Plug 'sudormrfbin/cheatsheet.nvim'

" Visuals
Plug 'dikiaap/minimalist'
Plug 'eruizc-dev/galaxyline.nvim', { 'branch': 'merge-all' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'onsails/lspkind-nvim'
Plug 'eruizc-dev/metropolis-vim'

" Git
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'

" Database
Plug 'tpope/vim-dadbod'         			" God bless tpope
Plug 'kristijanhusak/vim-dadbod-ui'     	" God bless kristijanhusak

" Snippets and completion
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'jameshiew/nvim-magic'
Plug 'ray-x/lsp_signature.nvim'

" LSP extensions
Plug 'RishabhRD/nvim-lsputils'
Plug 'simrat39/symbols-outline.nvim'

" File navigation
Plug 'nvim-telescope/telescope.nvim'    " God bles TJ
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'jvgrootveld/telescope-zoxide'

" Testing
Plug 'vim-test/vim-test'

" Terminal
Plug 'tpope/vim-dispatch'
Plug 'voldikss/vim-floaterm'

" Language specific
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
Plug 'mfussenegger/nvim-jdtls'
Plug 'shuntaka9576/preview-swagger.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-treesitter/playground'

call plug#end()
