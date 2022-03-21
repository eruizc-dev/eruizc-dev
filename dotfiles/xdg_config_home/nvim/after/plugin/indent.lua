vim.opt.termguicolors = true
vim.cmd [[hi! link IndentBlanklineInactive MetropolisGrey]]

require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
    char_highlight_list = {
        "IndentBlanklineInactive",
    },
}
