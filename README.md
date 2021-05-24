# Super neovim configuration

### To improve:

 - Run tests inside floaterm
    - Currenlty opens a `:term1`, I'd like for it to have a dedicated floaterm I
      can toggle.
 - Unified way to run programs
    - Golang runs with vim-go `:GoRun`
    - Java doesn't run and the intellij command is super long to put into a
      makefile. It also needs env variables that are not passed down.
 - Debbug
 - LSP save buffers on rename
    - Currently doing `:bufdo w`, which saves buffers I may not wanna save (like
      sql ones triggering dadbod.
 - Highlight spelling errors in markdown
 - Vertical alignment (`=`) to work in markdown
 - Better manage sessions, maybe vim-startify?
 - It's HIIIIDDDDEOUS when I open a file with ranger and it splits, can I have
   it fullscreen pls?
 - Try dadbod async branch
   <https://github.com/kristijanhusak/vim-dadbod-ui/issues/46>
 - Add sql lsp
 - Symbols-outline doesn't have \<silent\> tags
 - List of TODOS in project, with telescope maybe
 - I need Git diff what's right now vs what was a couple commits back or
 currently in another branch

### Features I should try

 - Nvim-compe's snippets

### Plugins I'm curious about:

[**vim-startify**](https://github.com/mhinz/vim-startify)
 - Don't forget to steal this amazing ascii art:
 <https://github.com/shaunsingh/vimrc/blob/3ac1dd5864223bf92f8c815f9483bd13fe344356/init.vim#L338>

[**git-worktree.nvim**](https://github.com/ThePrimeagen/git-worktree.nvim):
 - I need to learn about bare repos and worktrees before
 - <https://youtu.be/2uEqYw-N8uE>

[**vim-dispatch**](https://github.com/tpope/vim-dispatch):
 - This may solve some issues I currenlty have
 - I may need some better UI

[**vim-delve**](https://github.com/sebdah/vim-delve)
 - Debug golang within vim idk

[**vimspector**](https://github.com/puremourning/vimspector)
 - Debuggin

[**nvim-dap**](https://github.com/mfussenegger/nvim-dap)
 - More debuggin

[**nvim-dap-ui**](https://github.com/rcarriga/nvim-dap-ui)
 - Debuggin but ui

[**nvim-bqf**](https://github.com/kevinhwang91/nvim-bqf)
 - Better quickfix? I gotta try quickfix, I should try this after that

[**diffview**](https://github.com/sindrets/diffview.nvim)
 - Watch git diffs

[**defaults**](https://github.com/mjlbach/defaults.nvim)
 - Better vim defaults? Can it beat tpope's sensible.vim?

[**trouble-nvim**](https://github.com/folke/lsp-trouble.nvim)
 - I already solved mostly of the thing this plugin wants to fix, but I like the
   location list folding. Can I have that??

[**go.nvim**](https://github.com/ray-x/go.nvim)
 - Does it replace vim-go?

[**spellsitter.nvim**](https://github.com/lewis6991/spellsitter.nvim)

[**vim-SpellCheck**](https://github.com/inkarkat/vim-SpellCheck)

[**hologram.nvim**](https://github.com/edluffy/hologram.nvim)

[**vim-rails**](https://github.com/tpope/vim-rails)
 - Tpope
 - What else do you need?
 - Also rails

[**nvim-cheat.sh**](https://github.com/RishabhRD/nvim-cheat.sh)
 - cheats!

### Vimrcs I like to steal things from:

 - [Beginbot's](https://github.com/davidbegin/beginfiles/tree/master/nvim)
 - [ThePrimeagen's](https://github.com/awesome-streamers/awesome-streamerrc/tree/master/ThePrimeagen)
 - [Tpope's](https://github.com/tpope/tpope)
    - Vim god
 - [TJ](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)
    - Neovim god
 - [kraftwerk28](https://github.com/kraftwerk28/dotfiles/tree/master/.config/nvim)
    - Idk who he is but he's got a nice `utils.lua`  file
 - [mnabila](https://github.com/mnabila/nvimrc)
    - Cool galaxyline

