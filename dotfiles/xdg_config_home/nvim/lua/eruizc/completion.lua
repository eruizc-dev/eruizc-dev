local cmp = require('cmp')
local tabnine = require('cmp_tabnine.config')
local lspkind = require('lspkind')

cmp.setup({
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-h>'] = cmp.mapping.scroll_docs(-4),
    ['<C-l>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm()
  },
  sources = {
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vim-dadbod-completion' },
    { name = 'path' },
    { name = 'buffer' }
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
      vim_item.menu = ({
        cmp_tabnine = '',
      })[entry.source.name]
      return vim_item
    end
  }
})

tabnine:setup({
  max_lines = 1000;
  max_num_results = 20;
  sort = true;
})

lspkind.init({})
