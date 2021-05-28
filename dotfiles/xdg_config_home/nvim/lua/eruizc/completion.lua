local compe = require("compe")

vim.o.completeopt = "menuone,noselect"
compe.setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 25,
  max_kind_width = 25,
  max_menu_width = 25,
  documentation = true,

  source = {
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    path = true,
    vim_dadbod_completion = true,
  }
})
