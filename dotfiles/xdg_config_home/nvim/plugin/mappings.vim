"""NAVIGATION"""
nnoremap <silent> <C-K> :lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent> <C-J> :lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap <silent> <C-h> <C-o>
nnoremap <silent> <C-l> <C-i>

"""GOTOS"""
nnoremap <silent> gf    gF
nnoremap <silent> gr    :Telescope lsp_references<cr>
nnoremap <silent> gd    :Telescope lsp_definitions<cr>
nnoremap <silent> gi    :lua vim.lsp.buf.implementation()<cr>

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

"""CODE FAST"""
nnoremap <silent> ?         :lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> <leader>a :lua vim.lsp.buf.range_code_action()<cr>
nmap     <silent> +         <C-a>
nmap     <silent> -         <C-x>
vmap     <silent> +         <C-a>
vmap     <silent> -         <C-x>
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
tnoremap <silent> <A-esc>   <C-\><C-n>:FloatermHide!<cr>
nnoremap <silent> <A-esc>   :FloatermHide!<cr>

nnoremap <silent> <A-1> :FloatermToggle    --title=terminal term1<cr>
nnoremap <silent> <A-2> :FloatermToggle    --title=terminal term2<cr>
nnoremap <silent> <A-3> :FloatermToggle    --title=terminal term3<cr>
nnoremap <silent> <A-4> :FloatermToggle    --title=terminal term4<cr>
nnoremap <silent> <A-5> :FloatermToggle    --title=terminal term5<cr>
tnoremap <silent> <A-1> <C-\><C-n>:FloatermToggle    --title=terminal term1<cr>
tnoremap <silent> <A-2> <C-\><C-n>:FloatermToggle    --title=terminal term2<cr>
tnoremap <silent> <A-3> <C-\><C-n>:FloatermToggle    --title=terminal term3<cr>
tnoremap <silent> <A-4> <C-\><C-n>:FloatermToggle    --title=terminal term4<cr>
tnoremap <silent> <A-5> <C-\><C-n>:FloatermToggle    --title=terminal term5<cr>

"""TUIS"""
nnoremap <silent> <leader>lg        :FloatermTui    lazygit<cr>
nnoremap <silent> <leader>ld        :FloatermTui    lazydocker<cr>
nnoremap <silent> <leader>node      :FloatermTui    node<cr>
nnoremap <silent> <leader>spt       :FloatermTui    spt<cr>

"""UNDOS"""
nnoremap <silent> U <C-r>
nnoremap <silent> <leader>u :UndotreeToggle<bar>:UndotreeFocus<cr>

"""COMMAND MODE"""
set wildcharm=<Tab>
cnoremap <C-j> <Tab>
cnoremap <C-k> <S-Tab>
cnoremap <C-h> <up>
cnoremap <C-l> <down>

"""UNMAP"""
let g:zoomwintab_remap = v:false " Don't remap my <C-w-o> pls
nnoremap ZZ :echo"<< ===== C H E C K   C A P S   L O C K ===== >>"<cr>

