"""FILE NAVIGATION"""
nnoremap    <C-j>   <cmd>lua vim.diagnostic.goto_next()<cr>
nnoremap    <C-k>   <cmd>lua vim.diagnostic.goto_prev()<cr>
nnoremap    H       Hzz
nnoremap    L       Lzz
nnoremap    n       nzzzv
nnoremap    N       Nzzzv

"""PROJECT NAVIGATION"""
nnoremap    <C-n>   <cmd>cnext<cr>
nnoremap    <C-p>   <cmd>cprev<cr>
nnoremap    <C-h>   <C-o>
nnoremap    <C-l>   <C-i>

"""GOTOS"""
nnoremap    gr  <cmd>Telescope lsp_references<cr>
nnoremap    gd  <cmd>Telescope lsp_definitions<cr>
nnoremap    gi  <cmd>Telescope lsp_implementations<cr>

"""SPLITS"""
nnoremap    <C-o> <cmd>ZoomWinTabToggle<cr>

"""GIT"""
nnoremap    <leader>blame <cmd>GitMessenger<cr>
nnoremap    <leader>diff  <cmd>Gdiffsplit!<cr>

"""SEARCH FILES"""
nnoremap    <leader>p     <cmd>Telescope find_files find_command=rg,--files,--hidden,--no-ignore-global,-g,!.git/<CR>
nnoremap    <leader>P     <cmd>Telescope grep_string prompt_title=Rip\ &\ Tear search=<CR>
nnoremap    <leader>con   <cmd>Telescope find_files prompt_title=Configuration cwd=~/.config/nvim<cr>
nnoremap    <leader>z     <cmd>Telescope zoxide list<cr>

"""HELPERS"""
nnoremap    <leader>k     <cmd>Telescope help_tags<cr>

"""LANGUAGE SMARTNESS"""
nnoremap ?         <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <leader>a <cmd>lua vim.lsp.buf.range_code_action()<cr>

"""UNMAP"""
let g:zoomwintab_remap = v:false " Don't remap my <C-w-o> pls

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

nnoremap <leader>db <cmd>DebugToggleBreakpoint<cr>
nnoremap <leader>dc <cmd>DebugContinue<cr>
nnoremap <leader>do <cmd>DebugStepOver<cr>
nnoremap <leader>di <cmd>DebugStepInto<cr>
