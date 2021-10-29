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
        preview_height = 0.60,
        prompt_position = "bottom",
      },
      horizontal = {
        preview_width = 0.5,
        prompt_position = "bottom",
      }
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
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
telescope.load_extension("zoxide")

function finders.vimrc()
  builtin.find_files({
    prompt_title = "Configuration",
    cwd = "$HOME/.config/nvim",
  })
end

function finders.find_files()
  builtin.find_files({
    find_command = {
      "rg",
      "-g", "!.git",
      "-g", "!node_modules",
      "-g", "!package-lock.json",
      "-g", "!yarn.lock",
      "--files",
      "--hidden",
      "--no-ignore-global"
    }
  })
end

function finders.ripgrep()
  builtin.grep_string({
    find_command = {
      "rg",
      "-g", "!.git",
      "-g", "!node_modules",
      "-g", "!package-lock.json",
      "-g", "!yarn.lock",
      "--hidden",
      "--no-ignore-global",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    search = "",
  })
end

return finders

