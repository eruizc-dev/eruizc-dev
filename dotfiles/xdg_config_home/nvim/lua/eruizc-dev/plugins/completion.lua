return {
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		version = false, -- Last version is too old
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			{ 'hrsh7th/cmp-nvim-lua', ft = 'lua' },
			'onsails/lspkind-nvim',
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
			{
				'kristijanhusak/vim-dadbod-completion',
				ft = { 'sql', 'mysql', 'plsql' }
			},
		},
		opts = function(_, _opts)
			local cmp = require'cmp'
			vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
			return {
				preselect = cmp.PreselectMode.None,
				completion = {
					completeopt = 'menu,menuone,noinsert,noselect',
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
					['<C-h>'] = require'cmp'.mapping(function(_fallback)
						if require'luasnip'.jumpable(-1) then
							require'luasnip'.jump(-1)
						else
							require'cmp'.mapping.scroll_docs(-4)
						end
					end, { 'i', 's' }),
					['<C-l>'] = require'cmp'.mapping(function(_fallback)
						if require'luasnip'.expand_or_jumpable() then
							require'luasnip'.expand_or_jump()
						else
							require'cmp'.mapping.scroll_docs(4)
						end
					end, { 'i', 's' }),
				},
				sources = {
					{
						name = 'nvim_lsp',
						entry_filter = function(entry, context)
							local Kind = require'cmp.types.lsp'.CompletionItemKind
							local kind = entry:get_kind()
							local char_before_cursor = string.sub(context.cursor_line, context.cursor.col - 1, context.cursor.col - 1)
							if char_before_cursor == '.' then
								return kind == Kind.Method or kind == Kind.Field
							elseif string.match(context.cursor_line, '^%s*%w*$') then
								return kind == Kind.Function or kind == Kind.Variable
							else
								return true
							end
						end
					},
					{ name = 'nvim_lua' },
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'luasnip' },
					{ name = 'vim-dadbod-completion' },
				},
				formatting = {
					format = require'lspkind'.cmp_format({
						mode = 'symbol_text',
						maxwidth = 50,
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
	{
		'robitx/gp.nvim',
		cmd = {
			'GpAppend',
			'GpChatFinder',
			'GpChatNew',
			'GpChatToggle',
			'GpContext',
			'GpEnew',
			'GpImplement',
			'GpNew',
			'GpNextAgent',
			'GpPopup',
			'GpPrepend',
			'GpRewrite',
			'GpStop',
			'GpTabnew',
			'GpVnew',
			'GpWhisper',
			'GpWhisperAppend',
			'GpWhisperEnew',
			'GpWhisperNew',
			'GpWhisperPopup',
			'GpWhisperPrepend',
			'GpWhisperRewrite',
			'GpWhisperTabnew',
			'GpWhisperVnew',
			'GpExplain',
			'GpReview',
		},
		opts = function()
			return {
				providers = {
					ollama = {
						disabled = false,
						endpoint = 'http://localhost:11434/v1/chat/completions',
					},
				},
				agents = {
					{
						name = 'CodeGPT4o',
						disable = true,
					},
					{
						name = 'ChatGPT4o',
						disable = true,
					},
					{
						name = 'CodeGPT4o-mini',
						disable = true,
					},
					{
						name = 'ChatGPT4o-mini',
						disable = true,
					},
					{
						name = 'CodeOllamaLlama3.1-8B',
						disable = true,
					},
					{
						name = 'ChatOllamaLlama3.1-8B',
						disable = true,
					},
					{
						provider = 'ollama',
						name = 'ChatOllamaLlama3.2-8B',
						chat = true,
						command = false,
						model = {
							model = 'llama3.2',
							temperature = 0.6,
							top_p = 1,
							min_p = 0.05,
						},
						system_prompt = 'You are a general AI assistant.',
					},
					{
						provider = "ollama",
						name = "CodeOllamaLlama3.2-8B",
						chat = false,
						command = true,
						model = {
							model = "llama3.2",
							temperature = 0.4,
							top_p = 1,
							min_p = 0.05,
						},
						system_prompt = require("gp.defaults").code_system_prompt,
					},
				},
				hooks = {
					Review = function(gp, params)
						local template = "You are doing a code review the file {{filename}},"
						.. "respond with any bugs or concerns you have about the following code with suggestions to improve it:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n"
						gp.Prompt(params, gp.Target.popup, gp.get_chat_agent(), template)
					end,
				}
			}
		end
	}
}
