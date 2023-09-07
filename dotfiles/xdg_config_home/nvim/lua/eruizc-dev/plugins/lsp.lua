return {
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
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
		version = false, -- Last version is too old
		dependencies = {
			-- Sources
			'hrsh7th/cmp-nvim-lsp',
			{ 'hrsh7th/cmp-nvim-lua', ft = 'lua' },
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			--'kristijanhusak/vim-dadbod-completion',
			-- Style points
			'onsails/lspkind-nvim',
			-- Snippets
			{
				'saadparwaiz1/cmp_luasnip',
				dependencies = {
					{
						'L3MON4D3/LuaSnip',
						dependencies = {
							{
								'rafamadriz/friendly-snippets',
								config = function ()
									require'luasnip.loaders.from_vscode'.lazy_load()
								end
							}
						},
					}
				}
			},
			-- Copilot
			{
				'zbirenbaum/copilot-cmp',
				dependencies = {
					{
						'zbirenbaum/copilot.lua',
						cmd = 'Copilot',
						build = ':Copilot auth',
						opts = {
							suggestion = { enabled = false },
							panel = { enabled = false },
						},
						config = function()
							require('copilot').setup({})
						end,
					}
				},
				config = function ()
					require('copilot_cmp').setup()
				end
			}
		},
		opts = function(_, opts)
			vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
			return {
				completion = {
					completeopt = 'menu,menuone,noinsert',
				},
				snippet = {
					expand = function(args)
						require'luasnip'.lsp_expand(args.body)
					end,
				},
				mapping = {
					['<C-c>'] = require'cmp'.mapping.abort(),
					['<CR>'] = require'cmp'.mapping.confirm(),
					['<C-j>'] = require'cmp'.mapping.select_next_item({ behavior = require'cmp'.SelectBehavior.Select }),
					['<C-k>'] = require'cmp'.mapping.select_prev_item({ behavior = require'cmp'.SelectBehavior.Select }),
					['<C-h>'] = require'cmp'.mapping(function(fallback)
						if require'luasnip'.jumpable(-1) then
							require'luasnip'.jump(-1)
						else
							require'cmp'.mapping.scroll_docs(-4)
						end
					end, { 'i', 's' }),
					['<C-l>'] = require'cmp'.mapping(function(fallback)
						if require'luasnip'.expand_or_jumpable() then
							require'luasnip'.expand_or_jump()
						else
							require'cmp'.mapping.scroll_docs(4)
						end
					end, { 'i', 's' }),
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'luasnip' },
					{ name = 'copilot' },
					--{ name = 'vim-dadbod-completion' },
				},
				formatting = {
					format = require'lspkind'.cmp_format({
						mode = 'symbol_text',
						maxwidth = 50,
						symbol_map = { Copilot = '' }
					})
				},
				experimental = {
					ghost_text = {
						hl_group = 'CmpGhostText',
					},
				},
			}
		end,
	},
}
