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
nnoremap <silent> <leader>p         :Telescope find_files<cr>
nnoremap <silent> <leader>P 		:lua require("telescope.builtin").grep_string({ search = "" })<cr>
nnoremap <silent> <leader>s         :lua require("eruizc.telescope").find_sources()<cr>
nnoremap <silent> <leader>t         :lua require("eruizc.telescope").find_tests()<cr>
nnoremap <silent> <leader>config    :lua require("eruizc.telescope").vimrc()<cr>

"""CODE FAST"""
nnoremap <silent> ?         :lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>a :lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> <leader>a :lua vim.lsp.buf.range_code_action()<cr>

"""COMPLETION"""
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <cr> compe#confirm('<cr>')
inoremap <silent><expr> <space> compe#confirm('<space>')
inoremap <silent><expr> <C-h> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-l> compe#scroll({ 'delta': -4 })

"""TERMINALS"""
tnoremap <silent> <leader><esc>	<C-\><C-n>:FloatermHide!<cr>

nnoremap <silent> <leader>1 :FloatermToggle	--title=terminal term1<cr>
nnoremap <silent> <leader>2 :FloatermToggle	--title=terminal term2<cr>
nnoremap <silent> <leader>3 :FloatermToggle	--title=terminal term3<cr>
nnoremap <silent> <leader>4 :FloatermToggle	--title=terminal term4<cr>
nnoremap <silent> <leader>5 :FloatermToggle	--title=terminal term5<cr>

"""TUIS"""
"nnoremap <silent> <leader>f 	:FloatermTui	ranger<cr>
nnoremap <silent> <leader>lg	:FloatermTui	lazygit<cr>
nnoremap <silent> <leader>ld	:FloatermTui	lazydocker<cr>

"""UNDOS"""
nnoremap <silent> <leader>u :UndotreeToggle<bar>:UndotreeFocus<cr>


"""UNMAPS"""
nnoremap U :echo"<< ===== C H E C K   C A P S   L O C K ===== >>"<cr>
