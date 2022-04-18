local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup({
  completion = {
    completeopt = 'menuone,noselect'
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-h>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        cmp.mapping.scroll_docs(-4)
      end
    end, { 'i', 's' }),
    ['<C-l>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        cmp.mapping.scroll_docs(4)
      end
    end, { 'i', 's' }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vim-dadbod-completion' },
    { name = 'path' },
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50
    })
  }
})
