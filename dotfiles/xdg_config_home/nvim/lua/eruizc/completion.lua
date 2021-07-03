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
    buffer = { menu = '' },
    nvim_lsp = { menu = '' },
    nvim_lua = { menu = '' },
    path = { menu = '' }, -- THESE AIN'T WORKIIING, pls pr into compe
    calc = { menu = '' },
    vim_dadbod_completion = { menu = '' },
    tabnine = {
      menu = '',
      max_line = 1000,
      max_num_results = 6,
      priority = 5000,
      sort = false, -- setting to false means compe will leave tabnine to sort the completion items
      show_prediction_strength = true,
      ignore_pattern = ''
    }
  }
})
