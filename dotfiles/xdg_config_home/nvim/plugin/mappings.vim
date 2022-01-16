"""FILE NAVIGATION"""
nnoremap    <C-j>   <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap    <C-k>   <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap    H       Hzz
nnoremap    L       Lzz
nnoremap    n       nzzzv
nnoremap    N       Nzzzv

"""PROJECT NAVIGATION"""
nnoremap    <C-n>   <cmd>cnext<cr>
nnoremap    <C-p>   <cmd>cprev<cr>
nnoremap    <C-h>   <C-o>
nnoremap    <C-l>   <C-i>
nnoremap    <leader>m   <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap    <leader>'   <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap    'a   <cmd>lua require("harpoon.ui").nav_file(1)<cr>
nnoremap    's   <cmd>lua require("harpoon.ui").nav_file(2)<cr>
nnoremap    'd   <cmd>lua require("harpoon.ui").nav_file(3)<cr>
nnoremap    'f   <cmd>lua require("harpoon.ui").nav_file(4)<cr>

"""CODE EDIT"""
vnoremap    J   :m '>+1<cr>gv=gv
vnoremap    K   :m '<-2<cr>gv=gv
vnoremap    <   <gv
vnoremap    >   >gv
nnoremap    Y   y$
nnoremap    +   <C-a>
nnoremap    -   <C-x>
vnoremap    +   <C-a>
vnoremap    -   <C-x>
vnoremap    g+   g<C-a>
vnoremap    g-   g<C-x>

"""GOTOS"""
nnoremap    gf  gF
nnoremap    gr  <cmd>Telescope lsp_references<cr>
nnoremap    gd  <cmd>Telescope lsp_definitions<cr>
nnoremap    gi  <cmd>lua vim.lsp.buf.implementation()<cr>

"""SPLITS"""
nnoremap    <C-o> <cmd>ZoomWinTabToggle<cr>

"""GIT"""
nnoremap    <leader>blame <cmd>GitMessenger<cr>
nnoremap    <leader>diff  <cmd>Gdiffsplit!<cr>

"""SEARCH FILES"""
nnoremap    <leader>p     <cmd>lua require("eruizc.telescope").find_files()<cr>
nnoremap    <leader>P     <cmd>lua require("eruizc.telescope").ripgrep()<cr>
nnoremap    <leader>k     <cmd>Telescope help_tags<cr>
nnoremap    <leader>con   <cmd>lua require("eruizc.telescope").vimrc()<cr>
nnoremap    <leader>z     <cmd>Telescope zoxide list<cr>

"""HELPERS"""
nnoremap    <leader>cs    <cmd>Cheatsheet<cr>

"""LANGUAGE SMARTNESS"""
nnoremap ?         <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <leader>a <cmd>lua vim.lsp.buf.range_code_action()<cr>

"""COMPLETION"""
"inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : compe#complete()
"inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : compe#complete()
"inoremap <expr> <CR>    compe#confirm('<CR>')
"inoremap <expr> <C-l>   compe#scroll({ 'delta': +3 })
"inoremap <expr> <C-h>   compe#scroll({ 'delta': -3 })

"""TERMINALS"""
tnoremap <silent> <C-o>     <C-\><C-n>

nnoremap <C-q> <cmd>FloatermHide!<cr>
tnoremap <C-q> <cmd>FloatermHide!<cr>
tnoremap <C-l> <cmd>FloatermPrev<cr>
tnoremap <C-h> <cmd>FloatermNext<cr>

nnoremap <C-a> <cmd>FloatermNewOrToggle --title=Terminal\ 1<cr>
nnoremap <C-s> <cmd>FloatermNewOrToggle --title=Terminal\ 2<cr>
nnoremap <C-d> <cmd>FloatermNewOrToggle --title=Terminal\ 3<cr>
nnoremap <C-f> <cmd>FloatermNewOrToggle --title=Terminal\ 4<cr>
tnoremap <C-a> <cmd>FloatermNewOrToggle --title=Terminal\ 1<cr>
tnoremap <C-s> <cmd>FloatermNewOrToggle --title=Terminal\ 2<cr>
tnoremap <C-d> <cmd>FloatermNewOrToggle --title=Terminal\ 3<cr>
tnoremap <C-f> <cmd>FloatermNewOrToggle --title=Terminal\ 4<cr>

"""TUIS"""
nnoremap <leader>lg        <cmd>FloatermTui lazygit<cr>
nnoremap <leader>ld        <cmd>FloatermTui lazydocker<cr>
nnoremap <leader>spt       <cmd>FloatermTui spt<cr>

"""UNDOS"""
nnoremap U           <C-r>
nnoremap <leader>u   <cmd>UndotreeToggle<bar>UndotreeFocus<cr>

"""UNDO BREAKPOINTS"""
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u

"""COMMAND MODE"""
set wildcharm=<Tab>
cnoremap <C-j> <Tab>
cnoremap <C-k> <Tab><S-Tab><S-Tab>
cnoremap <C-h> <up>
cnoremap <C-l> <down>

"""UNMAP"""
let g:zoomwintab_remap = v:false " Don't remap my <C-w-o> pls
nnoremap ZZ :echo"<< ===== C H E C K   C A P S   L O C K ===== >>"<cr>

"""TESTING"""
nnoremap tt <cmd>TestLast<cr>
nnoremap ts <cmd>TestSuite<cr>
nnoremap tf <cmd>TestFile<cr>
nnoremap tn <cmd>TestNearest<cr>

"""DEBUG COMMANDS"""
command! DebugToggleBreakpoint lua require'dap'.toggle_breakpoint()
command! DebugContinue lua require'dap'.continue()
command! DebugStepOver lua require'dap'.step_over()
command! DebugStepInto lua require'dap'.step_into()
command! DebugInspect lua require'dap'.repl.open()
command! DebugRestart lua require'dap'.restart()
command! DebugClose lua require'dap'.close()
command! DebugEval lua require'dapui'.eval()
command! DebugToggle lua require'dapui'.toggle()
