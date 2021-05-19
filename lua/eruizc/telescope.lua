local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

local searchers = {}

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    width = 0.75,
    height = 0.95,
    color_devicons = true,
    layout_strategy = "vertical",
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
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
})

telescope.load_extension('fzf')

function searchers.vimrc()
  builtin.find_files({
    prompt_title = "Configuration",
    cwd = "$HOME/.config/nvim",
  })
end

return searchers

