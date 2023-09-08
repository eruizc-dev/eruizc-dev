return {
	{
		'mfussenegger/nvim-jdtls',
		ft = 'java',
		dependencies = {
			'mfussenegger/nvim-dap',
			'hrsh7th/cmp-nvim-lsp',
			{ 'williamboman/mason.nvim', opts = {} },
		},
		config = function ()
			require'eruizc-dev.utils.mason'.ensure_installed({ 'jdtls', 'java-test', 'java-debug-adapter' })

			require'jdtls'.start_or_attach({
				cmd = {
					vim.env.MASON .. '/packages/jdtls/jdtls',
					'--data',
					vim.fn.expand('$HOME/.cache/jdtls-workspace')
				},
				init_options = {
					bundles = require'eruizc-dev.utils.list'.join(
						vim.fn.glob(vim.env.MASON .. '/packages/java-debug-adapter/extension/server/*.jar'),
						vim.fn.glob(vim.env.MASON .. '/packages/java-test/extension/server/*.jar')
					)
				},
				settings = {
					java = {
						implementationsCodeLens = {
							enabled = true
						},
						completion = {
							importOrder = { }
						},
						sources = {
							organizeImports = {
								starThreshold = 2,
								staticStarThreshold = 2
							}
						},
					}
				},
				capabilities = require'cmp_nvim_lsp'.default_capabilities(),
				on_attach = function(client)
					require'jdtls.setup'.add_commands()
					require'jdtls'.update_project_config()
					require'jdtls'.setup_dap({ hotcodereplace = 'auto' })
				end
			})
		end
	}
}
