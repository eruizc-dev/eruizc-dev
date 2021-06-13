"""JUMPS"""
nnoremap <silent> <C-j> :lnext<cr>
nnoremap <silent> <C-k> :lprevious<cr>
nnoremap <silent> <C-h> <C-o>
nnoremap <silent> <C-l> <C-i>

"""GOTOS"""
nnoremap <silent> gr    :Telescope lsp_references<cr>
nnoremap <silent> gd    :Telescope lsp_definitions<cr>
nnoremap <silent> gi    :lua vim.lsp.buf.implementation()<cr>

"""BUFFER"""
nnoremap <silent> <C-o>         :ZoomWinTabToggle<cr>
nnoremap <silent> <C-W>o        :only<cr>
nnoremap <silent> <C-w_o>       :only<cr>
nnoremap <silent> <C-w><C-o>    :only<cr>

"""GIT"""
nnoremap <silent> <leader>blame :GitMessenger<cr>

"""SEARCH FILES"""
nnoremap <silent> <leader>p         :lua require("eruizc.telescope").find_files()<cr>
nnoremap <silent> <leader>P         :lua require("eruizc.telescope").ripgrep()<cr>
nnoremap <silent> <leader>s         :lua require("eruizc.telescope").find_sources()<cr>
nnoremap <silent> <leader>t         :lua require("eruizc.telescope").find_tests()<cr>
nnoremap <silent> <leader>config    :lua require("eruizc.telescope").vimrc()<cr>

"""HELPERS"""
nnoremap <silent> <leader>cs    :Cheatsheet<cr>

"""CODE FAST"""
nnoremap <silent> ?         :lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> <leader>a :lua vim.lsp.buf.range_code_action()<cr>

"""COMPLETION"""
inoremap <silent> <C-j> <C-n>
inoremap <silent> <C-k> <C-p>
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-h> compe#scroll({ 'delta': +3 })
inoremap <silent><expr> <C-l> compe#scroll({ 'delta': -3 })

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

"""UNDOS"""
nnoremap <silent> <leader>u :UndotreeToggle<bar>:UndotreeFocus<cr>

"""UNMAPS"""
nnoremap U :echo"<< ===== C H E C K   C A P S   L O C K ===== >>"<cr>
let g:zoomwintab_remap = v:false


