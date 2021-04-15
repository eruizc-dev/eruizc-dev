lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    color_devicons = true,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = actions.preview_scrolling_up,
        ["<C-l>"] = actions.preview_scrolling_down,
      },
    },
  },
}
EOF

nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>P <cmd>Telescope live_grep<cr>
