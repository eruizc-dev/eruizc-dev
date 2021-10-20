# Super neovim configuration

### To improve:

 - Run tests inside floaterm
    - Currenlty opens a `:term1`, I'd like for it to have a dedicated floaterm I
      can toggle.
 - Unified way to run programs
    - Golang runs with vim-go `:GoRun`
    - Java doesn't run (with maven) and the intellij command is super long to
    put into a makefile. It also needs env variables that are not passed down.
 - LSP save buffers on rename
    - Currently doing `:bufdo w`, which saves buffers I may not wanna save (like
      sql ones triggering dadbod.
 - Highlight spelling errors in markdown
 - Vertical alignment (`=`) to work in markdown
 - Better manage sessions, maybe vim-startify? Harpoon?
 - It's HIIIIDDDDEOUS when I open a file with ranger and it splits, can I have
   it fullscreen pls?
 - Try dadbod async branch
   <https://github.com/kristijanhusak/vim-dadbod-ui/issues/46>
 - `TestNearest` doesn't work with gradle in nested classes
 - Telescope source files hides files I wanna search!
    - I wanna be able so see gitignored config files like .evn
    - I wanna be able to see hidden files like .gitignore or .github/
    - I don't wanna see gitignored directories like node_moudles/ or build/
 - Preview images with telescope
 - Some projects have large json files, I don't want telescope ripgrep to look
   into them.
 - Compe icons for paths are not working

### Thins I'd like to work on

 - Implement [make-lsp](https://github.com/alexclewontin/make-lsp-vscode) into
   lspconfig
 - Better [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) defaults.
   Maybe change nvim/nvim-lspconfig default to better support Java

### Features I should try

 - Nvim-compe's snippets

### Plugins I'm curious about:

#### Utils

 - [**harpoon**](https://github.com/ThePrimeagen/harpoon)
 - [**LuaSnip**](https://github.com/L3MON4D3/LuaSnip)
 - [**navigator.lua**](https://github.com/ray-x/navigator.lua): I love vi{, ci{
   and others, the thing is that it doesn't work in languages like Python, Ruby,
   Lua or even C if you have a one-line if.
 - [**nvim-treesitter-textobjects**](https://github.com/nvim-treesitter/nvim-treesitter-textobjects):
   Same as navigator.lua, but I think I like it better
 - [**nvim-ts-context-commentstring**](https://github.com/JoosepAlviste/nvim-ts-context-commentstring):
   Name too long, but basically comment line(s) with treesitter
 - [**auto-session**](https://github.com/rmagatti/auto-session)
 - [**context.vim**](https://github.com/wellle/context.vim)
 - [**vim-hexokinase**](https://github.com/RRethy/vim-hexokinase)

#### Git

 - [**git-worktree.nvim**](https://github.com/ThePrimeagen/git-worktree.nvim): <https://youtu.be/2uEqYw-N8uE>
 - [**diffview**](https://github.com/sindrets/diffview.nvim)
 - [**vgit.nvim**](https://github.com/tanvirtin/vgit.nvim): fugitive but lua

#### Debug

 - [**vim-delve**](https://github.com/sebdah/vim-delve): golang debug
 - [**vimspector**](https://github.com/puremourning/vimspector): vim debugg
 - [**nvim-dap**](https://github.com/mfussenegger/nvim-dap): debug adapter
   protocol
 - [**nvim-dap-ui**](https://github.com/rcarriga/nvim-dap-ui): dap ui
 - [**nvim-bqf**](https://github.com/kevinhwang91/nvim-bqf): Better quickfix
 - [**trouble-nvim**](https://github.com/folke/lsp-trouble.nvim): I already
   solved mostly of the thing this plugin wants to fix, but I like the location
   list folding. Can I have that??

#### Language specifig

 - [**vim-go**](https://github.com/fatih/vim-go): long install/update times, and
   breaks with lsp... Was that fixed?
 - [**go.nvim**](https://github.com/ray-x/go.nvim): Does it replace vim-go?
 - [**vim-rails**](https://github.com/tpope/vim-rails): tpope and rails

#### Spelling

 - [**spellsitter.nvim**](https://github.com/lewis6991/spellsitter.nvim)
 - [**vim-SpellCheck**](https://github.com/inkarkat/vim-SpellCheck)

#### Styling

 - [**hologram.nvim**](https://github.com/edluffy/hologram.nvim)
 - [**vim-startify**](https://github.com/mhinz/vim-startify)
    - Don't forget to steal this amazing ascii art:
      <https://github.com/shaunsingh/vimrc/blob/3ac1dd5864223bf92f8c815f9483bd13fe344356/init.vim#L338>

### Vimrcs I like to steal things from:

 - [Beginbot's](https://github.com/davidbegin/beginfiles/tree/master/nvim)
 - [ThePrimeagen's](https://github.com/awesome-streamers/awesome-streamerrc/tree/master/ThePrimeagen)
 - [Tpope's](https://github.com/tpope/tpope): Vim god
 - [TJ](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim): Neovim god
 - [kraftwerk28](https://github.com/kraftwerk28/dotfiles/tree/master/.config/nvim): nice `utils.lua`
 - [mnabila](https://github.com/mnabila/nvimrc): Cool galaxyline
 - [elianiva](https://github.com/elianiva/dotfiles): Thanks for the efm configuration <3
 - [siduck76](https://github.com/siduck76/NvChad): Cool dragon
