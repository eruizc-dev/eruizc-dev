local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

local searchers = {}

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    width = 0.75,
    height = 0.95,
	shorten_path = true,
    color_devicons = true,
    layout_strategy = "horizontal",
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

function searchers.find_sources()
  local test_files = vim.g.tests_directory and vim.g.tests_directory.."/*"
  builtin.find_files({
    prompt_title = "Source Files",
    cwd = vim.g.source_directory or "./",
	file_ignore_patterns = { test_files }
  })
end

function searchers.find_tests()
  local source_files = vim.g.source_directory and vim.g.source_directory.."/*"
  builtin.find_files({
    prompt_title = "Test Files",
    cwd = vim.g.tests_directory or "./",
	file_ignore_patterns = { source_files }
  })
end

return searchers

