vim.cmd[[set tabstop=4]]

require'jdtls'.start_or_attach({
	cmd = { vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls' },
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
		}
	},
	capabilities = require'cmp_nvim_lsp'.default_capabilities(),
	on_attach = function(_client)
		require'jdtls'.update_project_config()
	end
})
