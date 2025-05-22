vim.cmd[[setlocal tabstop=4]]
vim.cmd[[setlocal colorcolumn=120]]

require'eruizc-dev.utils.mason'.ensure_installed({
	'jdtls',
	'java-test',
	'java-debug-adapter',
})

local available_runtimes = vim.split(vim.fn.glob('$HOME/.sdkman/candidates/java/21*'), '\n')

require'jdtls'.start_or_attach({
	cmd = {
		vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
		('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
		'-data', vim.fn.glob'$HOME/.cache/jdtls'
	},
	cmd_env = {
		JAVA_HOME = available_runtimes[#available_runtimes]
	},
	init_options = {
		bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', true), '\n'),
	},
	settings = {
		java = {
			jdt = {
				ls = {
					lombokSupport = {
						enabled = true
					}
				}
			},
			implementationsCodeLens = {
				enabled = true
			},
			completion = {
				importOrder = { }
			},
			sources = {
				organizeImports = {
					starThreshold = 3,
					staticStarThreshold = 3
				}
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = vim.fn.expand'$HOME/.sdkman/candidates/java/17.0.10-tem/'
					},
					{
						name = "JavaSE-21",
						path = vim.fn.expand'$HOME/.sdkman/candidates/java/21.0.4-tem/'
					},
					{
						name = "JavaSE-23",
						path = vim.fn.expand'$HOME/.sdkman/candidates/java/23-tem/'
					},
				}
			},
		}
	},
	capabilities = require'cmp_nvim_lsp'.default_capabilities(),
	on_attach = function(_client)
		require'jdtls'.update_project_config()
	end
})
