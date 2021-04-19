# Super neovim configuration

### To improve:

**Testing**: brought to you by vim-test

 - [x] Run all tests
 - [x] Run a single test
 - [] Output in accesible floaterm
    - Currenlty opens a `:term1`, I'd like for it to have a dedicated floaterm I
      can toggle.

**Developing**:

 - [] Launch programs within vim
    - Like `:make` but more global
 - [] Jump to issue
    - When I change something and breaks in a buffer I don't have open I have
      for the program to compile and fail to know it. Maybe QuickFixList?

**File management**:

 - [] Create/Delete files within vim
    - Automatic snippets for file creation (like java, automagically add package
      and class information.
    - Netrw navigation too slow...
    - Nerdtree navigation better but file creation sucks having to open menu

**Miscelaneous**: (Is that how you spell it?)
 - Telescope result window is too big, preview window too small
 - LSP save buffers on rename
    - Currently doing `:bufdo w`, which saves buffers I may not wanna save (like
      sql ones triggering dadbod.
 - Highlight spelling errors in markdown
 - `=` to work in markdown

### Features I should try

 - QuickFixList
    - <https://youtu.be/IoyW8XYGqjM>
 - Nvim-compe's snippets

### Plugins I'm curious about:

[**git-messenger**](https://github.com/rhysd/git-messenger.vim):
 - (git) Blame my coworkers

[**git-worktree.nvim**](https://github.com/ThePrimeagen/git-worktree.nvim):
 - I need to learn about bare repos and worktrees before
 - <https://youtu.be/2uEqYw-N8uE>

[**vim-dispatch**](https://github.com/tpope/vim-dispatch):
 - This may solve some issues I currenlty have
 - I may need some better UI

[**vim-delve**](https://github.com/sebdah/vim-delve)
 - Debug golang within vim idk

[**telescope-fzf-native.vim**](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
 - Telescope default searcher is not that great...

[**lsp-symbols**](https://github.com/simrat39/symbols-outline.nvim):
 - Cool

### Vimrcs I like to steal things from:

 - [Beginbot's](https://github.com/davidbegin/beginfiles/tree/c72ef20f9c613528af9f7b34be8d03093ad0d873/nvim)
 - [ThePrimeagen's](https://github.com/awesome-streamers/awesome-streamerrc/tree/master/ThePrimeagen)
 - [Tpope's](https://github.com/tpope/tpope)

