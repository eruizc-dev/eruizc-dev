"""FILE NAVIGATION"""
nnoremap <silent>   J   :lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap <silent>   K   :lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap            H   Hzz
nnoremap            L   Lzz
nnoremap            n   nzzzv
nnoremap            N   Nzzzv

"""PROJECT NAVIGATION"""
nnoremap <silent>   <C-j>   :cabove<cr>
nnoremap <silent>   <C-k>   :cbelow<cr>
nnoremap            <C-h>   <C-o>
nnoremap            <C-l>   <C-i>

"""CODE EDIT"""
vnoremap    J   :m '>+1<cr>gv=gv
vnoremap    K   :m '<-2<cr>gv=gv
vnoremap    <   <gv
vnoremap    >   >gv
nnoremap    Y   y$
map         +   <C-a>
map         -   <C-x>

"""GOTOS"""
nnoremap            gf  gF
nnoremap <silent>   gr  :Telescope lsp_references<cr>
nnoremap <silent>   gd  :Telescope lsp_definitions<cr>
nnoremap <silent>   gi  :lua vim.lsp.buf.implementation()<cr>

"""SPLITS"""
nnoremap <silent> <C-o> :ZoomWinTabToggle<cr>

"""GIT"""
nnoremap <silent> <leader>blame :GitMessenger<cr>
nnoremap <silent> <leader>diff  :Gdiffsplit!<cr>

"""SEARCH FILES"""
nnoremap <silent> <leader>p     :lua require("eruizc.telescope").find_files()<cr>
nnoremap <silent> <leader>P     :lua require("eruizc.telescope").ripgrep()<cr>
nnoremap <silent> <leader>con   :lua require("eruizc.telescope").vimrc()<cr>

"""HELPERS"""
nnoremap <silent> <leader>cs    :Cheatsheet<cr>

"""LANGUAGE SMARTNESS"""
nnoremap <silent> ?         :lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> <leader>a :lua vim.lsp.buf.range_code_action()<cr>
augroup jdtls
    au!
    au FileType java noremap <buffer> <silent> <leader>a :lua require'jdtls'.code_action()<cr>
    au FileType java noremap <buffer> <silent> <leader>a :lua require'jdtls'.code_action(true)<cr>
augroup end

"""COMPLETION"""
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : compe#complete()
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : compe#complete()
inoremap <expr> <CR> compe#confirm('<CR>')
inoremap <expr> <C-h> compe#scroll({ 'delta': +3 })
inoremap <expr> <C-l> compe#scroll({ 'delta': -3 })

"""TERMINALS"""
tnoremap <silent> <C-o>     <C-\><C-n>

nnoremap <silent> <A-esc>   :FloatermHide!<cr>
nnoremap <silent> <A-h> :FloatermNext<cr>
nnoremap <silent> <A-l> :FloatermPrev<cr>
tnoremap <silent> <A-esc>   <C-\><C-n>:FloatermHide!<cr>
tnoremap <silent> <A-h> <C-\><C-n>:FloatermNext<cr>
tnoremap <silent> <A-l> <C-\><C-n>:FloatermPrev<cr>

nnoremap <silent> <A-1> :FloatermNewOrToggle    --title=Terminal\ 1<cr>
nnoremap <silent> <A-2> :FloatermNewOrToggle    --title=Terminal\ 2<cr>
nnoremap <silent> <A-3> :FloatermNewOrToggle    --title=Terminal\ 3<cr>
nnoremap <silent> <A-4> :FloatermNewOrToggle    --title=Terminal\ 4<cr>
nnoremap <silent> <A-5> :FloatermNewOrToggle    --title=Terminal\ 5<cr>
tnoremap <silent> <A-1> <C-\><C-n>:FloatermNewOrToggle  --title=Terminal\ 1<cr>
tnoremap <silent> <A-2> <C-\><C-n>:FloatermNewOrToggle  --title=Terminal\ 2<cr>
tnoremap <silent> <A-3> <C-\><C-n>:FloatermNewOrToggle  --title=Terminal\ 3<cr>
tnoremap <silent> <A-4> <C-\><C-n>:FloatermNewOrToggle  --title=Terminal\ 4<cr>
tnoremap <silent> <A-5> <C-\><C-n>:FloatermNewOrToggle  --title=Terminal\ 5<cr>

"""TUIS"""
nnoremap <silent> <leader>lg        :FloatermTui    lazygit<cr>
nnoremap <silent> <leader>ld        :FloatermTui    lazydocker<cr>
nnoremap <silent> <leader>node      :FloatermTui    node<cr>
nnoremap <silent> <leader>spt       :FloatermTui    spt<cr>

"""UNDOS"""
nnoremap <silent>   U           <C-r>
nnoremap <silent>   <leader>u   :UndotreeToggle<bar>:UndotreeFocus<cr>

"""UNDO BREAKPOINTS"""
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u

"""COMMAND MODE"""
set wildcharm=<Tab>
cnoremap <C-j> <Tab>
cnoremap <C-k> <S-Tab>
cnoremap <C-h> <up>
cnoremap <C-l> <down>

"""UNMAP"""
let g:zoomwintab_remap = v:false " Don't remap my <C-w-o> pls
nnoremap ZZ :echo"<< ===== C H E C K   C A P S   L O C K ===== >>"<cr>

