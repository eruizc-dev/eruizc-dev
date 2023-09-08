local root = require'mason-registry'.get_package'jdtls':get_install_path()

require'jdtls'.start_or_attach({
	cmd = {
		root .. '/jdtls',
		'--data',
		vim.fn.expand('$HOME/.cache/jdtls-workspace'),
		('--jvm-arg=-javaagent:%s'):format(root .. '/lombok.jar'),
	},
	init_options = {
		bundles = require'eruizc-dev.utils.list'.join(
		vim.fn.glob(require'mason-registry'.get_package'java-debug-adapter':get_install_path() .. '/extension/server/*.jar'),
		vim.fn.glob(require'mason-registry'.get_package'java-test':get_install_path() .. '/extension/server/*.jar')
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

