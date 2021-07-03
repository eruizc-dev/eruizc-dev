local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

local finders = {}

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    color_devicons = true,
    layout_strategy = "vertical",
    layout_config = {
      width = 0.80,
      height = 0.90,
      preview_cutoff = 0.5,
      vertical = {
        preview_height = 0.5,
      },
      horizontal = {
        preview_width = 0.5,
      }
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

telescope.load_extension("fzf")
telescope.load_extension("rubberduck")

local function get_source_files()
  return vim.g.source_directory and vim.g.source_directory.."/*"
end

local function get_test_files()
  return vim.g.test_directory and vim.g.test_directory.."/*"
end

function finders.vimrc()
  builtin.find_files({
    prompt_title = "Configuration",
    cwd = "$HOME/.config/nvim",
  })
end

function finders.find_files()
  builtin.find_files({
    layout_strategy = "vertical",
    find_command = { 'rg', '--files', '--hidden', '--no-ignore-global' }
  })
end

function finders.find_sources()
  local source_files = get_source_files()
  local test_files = get_test_files()
  local title = (source_files and "Source Files ("..source_files..")") or "Source Files"
  builtin.find_files({
    prompt_title = title,
    layout_strategy = "horizontal",
    cwd = vim.g.source_directory or "./",
    file_ignore_patterns = { test_files }
  })
end

function finders.find_tests()
  local source_files = get_source_files()
  local test_files = get_test_files()
  local title = (test_files and "Test Files ("..test_files..")") or "Test Files"
  builtin.find_files({
    prompt_title = title,
    layout_strategy = "horizontal",
    cwd = vim.g.test_directory or "./",
    file_ignore_patterns = { source_files }
  })
end

function finders.ripgrep()
  builtin.grep_string({
    find_command = { 'rg',
      '--hidden',
      '--no-ignore-global',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    search = "",
    layout_strategy = "horizontal",
  })
end

return finders

