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

"""SPLITS"""
nnoremap    <C-o> <cmd>ZoomWinTabToggle<cr>

"""GIT"""
nnoremap    <leader>diff  <cmd>Gdiffsplit!<cr>

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
