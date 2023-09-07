return {
	{
		'mfussenegger/nvim-jdtls',
		ft = { 'java' },
		dependencies = { 'mfussenegger/nvim-dap' },
		config = function ()
			local jdtls = require('jdtls')
			local jdtls_setup = require('jdtls.setup')

			--local bundles = { vim.fn.glob('$HOME/repos/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar') }
			--vim.list_extend(bundles, vim.split(vim.fn.glob('$HOME/repos/microsoft/vscode-java-test/server/*.jar'), '\n'))
			jdtls.start_or_attach({
				cmd = { 'jdt-language-server', '-data', vim.fn.expand('$HOME/.cache/jdtls-workspace') },
				root_dir = jdtls_setup.find_root({ '*.gradle', 'pom.xml' }),
				init_options = {
					--bundles = bundles
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
				capabilities = require'lspconfig'.util.default_config.capabilities,
				on_attach = function(client)
					jdtls_setup.add_commands()
					jdtls.update_project_config()
					--jdtls.setup_dap({ hotcodereplace = 'auto' })
				end
			})
		end
	}
}
