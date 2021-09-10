local cmp = require'cmp'
local tabnine = require('cmp_tabnine.config')

cmp.setup({
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-h>'] = cmp.mapping.scroll_docs(-4),
    ['<C-l>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.complete() and cmp.mapping.close()
  },
  sources = {
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
  }
})

tabnine:setup({
  max_lines = 1000;
  max_num_results = 20;
  sort = true;
})
