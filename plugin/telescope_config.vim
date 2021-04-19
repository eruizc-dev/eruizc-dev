lua << EOF
local telescope = require('telescope')
local actions = require('telescope.actions')
telescope.setup{
    defaults = {
        color_devicons = true,
        layout_defaults = {
            horizontal = {
                preview_width = 0.50
            },
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-h>"] = actions.preview_scrolling_up,
                ["<C-l>"] = actions.preview_scrolling_down,
            },
        },
    },
    extensions = {
        fzf = {
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
}
telescope.load_extension('fzf')
EOF

command! Planets :lua require'telescope.builtin'.planets{}<cr>

nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>P <cmd>Telescope live_grep<cr>

nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
