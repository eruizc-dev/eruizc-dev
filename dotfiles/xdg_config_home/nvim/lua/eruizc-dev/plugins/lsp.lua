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
	}
}
