local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

local finders = {}

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    width = 0.75,
    height = 0.95,
    color_devicons = true,
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        preview_width = 0.5
      },
	  vertical = {
		  preview_height = 0.65
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
    search = "",
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.98
    },
  })
end

return finders

