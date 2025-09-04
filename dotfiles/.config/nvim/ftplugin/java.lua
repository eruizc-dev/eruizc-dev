vim.cmd[[setlocal tabstop=4]]
vim.cmd[[setlocal colorcolumn=120]]

local jdtls_enabled, jdtls = pcall(require, 'jdtls')

if not jdtls_enabled then
	return
end

require'eruizc-dev.utils.mason'.ensure_installed({
	'java-test',
	'java-debug-adapter',
})

jdtls.start_or_attach({
	cmd = { 'jdtls' },
	root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
	init_options = {
		bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', true), '\n'),
	},
	settings = {
		java = {
			signature_help = { enabled = true },
			['jdt.ls.lombokSupport'] = { enabled = true },
			completion = { importOrder = { } },
			sources = {
				organizeImports = {
					starThreshold = 3,
					staticStarThreshold = 3
				}
			},
			maven = { downloadSources = true, },
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = 'all', -- literals, all, none
				},
			}
		}
	},
	capabilities = jdtls.extendedClientCapabilities,
})
