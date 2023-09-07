return {
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			diagnostics = { -- options for vim.diagnostic.config()
				underline = true,
				virtual_text = {
					severity = vim.diagnostic.severity.WARN,
					source = 'if_many',
					spacing = 4,
				},
				signs = false,
				severity_sort = true,
				update_in_insert = false,
			},
			inlay_hints = { enabled = true },
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = 'LuaJIT' }, -- Which version, LuaJIT for Neovim
							workspace = {
								library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
								checkThirdParty = false,
							},
							diagnostics = { globals = { 'vim' } },
							telemetry = { enable = false },
						},
					},
				},
				vimls = {},
			},
		},
		config = function(_, opts)
			for server, server_opts in pairs(opts.servers) do
				require('lspconfig')[server].setup(server_opts)
			end
			vim.diagnostic.config(opts) -- Must be after setup
		end,
	},
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			-- Sources
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			--'kristijanhusak/vim-dadbod-completion',
			-- Snippets
			-- 'L3MON4D3/LuaSnip'
			--'saadparwaiz1/cmp_luasnip',
			-- Style points
			'onsails/lspkind-nvim',
		},
		opts = function(_, opts)
			return {
				completion = {
					completeopt = 'menu,menuone,noinsert',
				},
				mapping = {
					['<C-c>'] = require'cmp'.mapping.abort(),
					['<CR>'] = require'cmp'.mapping.confirm(),
					['<C-j>'] = require'cmp'.mapping.select_next_item({ behavior = require'cmp'.SelectBehavior.Select }),
					['<C-k>'] = require'cmp'.mapping.select_prev_item({ behavior = require'cmp'.SelectBehavior.Select }),
					['<C-h>'] = require'cmp'.mapping.scroll_docs(-4),
					['<C-l>'] = require'cmp'.mapping.scroll_docs(4),
				},
				sources = {
					--{ name = 'luasnip' },
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					{ name = 'buffer' },
					{ name = 'path' },
					--{ name = 'vim-dadbod-completion' },
				},
				formatting = {
					format = require'lspkind'.cmp_format({
						mode = 'symbol_text',
						maxwidth = 50
					})
				},
			}
		end,
	}
}
