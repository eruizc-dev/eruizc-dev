vim.o.ch = 0;
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 250,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'branch' },
    lualine_b = { 'diff' },
    lualine_c = {
      { 'filetype', icon_only = true },
      { 'filename', path = 1, symbols = { modified = '', readonly = '', unnamed = '', newfile = '' } }
    },
    lualine_x = {{
      'diagnostics',
      always_visible = true,
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      sources = { 'nvim_diagnostic' },
      sections = { 'hint', 'info', 'warn', 'error' }
    }},
    lualine_y = {{
      'diagnostics',
      always_visible = true,
      symbols = { error = ' ', warn = ' ' },
      sources = { 'nvim_workspace_diagnostic' },
      sections = { 'warn', 'error' }
    }},
    lualine_z = { 'encoding', 'fileformat' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
