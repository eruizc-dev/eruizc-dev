local function path(package)
	return require'mason-registry'.get_package(package):get_install_path()
end

local root = path'jdtls'
require'jdtls'.start_or_attach({
	cmd = {
		'jdtls',
		'--data',
		vim.fn.expand('$HOME/.cache/jdtls-workspace'),
		('--jvm-arg=-javaagent:%s'):format(root .. '/lombok.jar'),
	},
	init_options = {
		bundles = require'eruizc-dev.utils.list'.join(
			vim.fn.glob(path'java-debug-adapter' .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', 1) ,
			vim.split(vim.fn.glob(path'java-test' .. '/extension/server/*.jar', 1), "\n")
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
					starThreshold = 3,
					staticStarThreshold = 3
				}
			},
		}
	},
	capabilities = require'cmp_nvim_lsp'.default_capabilities(),
	on_attach = function(_client)
		require'jdtls.setup'.add_commands()
		require'jdtls'.update_project_config()
		require'jdtls'.setup_dap({ hotcodereplace = 'auto' })
	end
})

