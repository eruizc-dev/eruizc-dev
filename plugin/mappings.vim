"""JUMPS"""
nnoremap <silent> <C-j> :lnext<cr>
nnoremap <silent> <C-k> :lprevious<cr>
nnoremap <silent> <C-h> <C-o>
nnoremap <silent> <C-l> <C-i>

"""GOTOS"""
nnoremap <silent> gf    gf
nnoremap <silent> gr    :Telescope lsp_references<cr>
nnoremap <silent> gd    :Telescope lsp_definitions<cr>
nnoremap <silent> gi    :lua vim.lsp.buf.implementation()<cr>

"""GIT"""
nnoremap <silent> <leader>blame :GitMessenger<cr>

"""SEARCH FILES"""
nnoremap <silent> <leader>p         :lua require'eruizc.telescope'.find_sources()<cr>
nnoremap <silent> <leader>t         :lua require'eruizc.telescope'.find_tests()<cr>
nnoremap <silent> <leader>P         :Telescope live_grep<cr>
nnoremap <silent> <leader>config    :lua require("eruizc.telescope").vimrc()<cr>
nnoremap <silent> <C-p> :NERDTreeToggle<CR>

"""CODE FAST"""
nnoremap <silent> ?         :lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<cr>

"""TERMINALS"""
tnoremap <silent> <leader><esc>	<C-\><C-n>:FloatermHide!<cr>

nnoremap <silent> <leader>1 :FloatermToggle	--title=terminal term1<cr>
nnoremap <silent> <leader>2 :FloatermToggle	--title=terminal term2<cr>
nnoremap <silent> <leader>3 :FloatermToggle	--title=terminal term3<cr>
nnoremap <silent> <leader>4 :FloatermToggle	--title=terminal term4<cr>
nnoremap <silent> <leader>5 :FloatermToggle	--title=terminal term5<cr>

"""TUIS"""
nnoremap <silent> <leader>f 	:FloatermTui	ranger<cr>
nnoremap <silent> <leader>lg	:FloatermTui	lazygit<cr>
nnoremap <silent> <leader>ld	:FloatermTui	lazydocker<cr>

"""UNDOS"""
nnoremap <silent> <leader>u :UndotreeToggle<bar>:UndotreeFocus<CR>


"""UNMAPS"""
nnoremap U :echo"<< ===== C H E C K   C A P S   L O C K ===== >>"<cr>

