local cmp = require('cmp')
local tabnine = require('cmp_tabnine.config')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local nvim_magic = require('nvim-magic')

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
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vim-dadbod-completion' },
    { name = 'path' },
    { name = 'buffer' },
  },
  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == 'cmp_tabnine' then
        vim_item.kind = ' Guess'
      else
        vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind
      end
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

nvim_magic.setup({
	use_default_keymap = true,
	backends = {
		default = require('nvim-magic-openai').new({
      api_endpoint = 'https://api.openai.com/v1/engines/cushman-codex/completions'
    })
	}
})
