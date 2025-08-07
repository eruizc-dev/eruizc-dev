vim.cmd[[setlocal tabstop=4]]
vim.cmd[[setlocal colorcolumn=120]]

local jdtls_enabled, jdtls = pcall(require, 'jdtls')

if not jdtls_enabled then
	return
end

require'eruizc-dev.utils.mason'.ensure_installed({
	'jdtls',
	'lombok-nightly',
	'java-test',
	'java-debug-adapter',
})

local function latest_runtime(major)
	major = major or '21'
	local root = ('$SDKMAN_DIR/candidates/java/%s*'):format(major)
	local runtimes = vim.split(vim.fn.glob(root), '\n')
	return runtimes[#runtimes]
end

jdtls.start_or_attach({
	cmd = {
		vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
		('--jvm-arg=-javaagent:%s/lombok.jar'):format(require'mason-core.installer.InstallLocation'.global():package('lombok-nightly')),
		'-data', ('%s/.local/share/nvim/jdtls-workspace/%s'):format(os.getenv'HOME', vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'))
	},
	cmd_env = {
		JAVA_HOME = latest_runtime('21')
	},
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
			},
			configuration = {
				runtimes = {
					{ name = 'JavaSE-17', path = latest_runtime('17') },
					{ name = 'JavaSE-21', path = latest_runtime('21') },
					{ name = 'JavaSE-23', path = latest_runtime('23') },
				}
			},
		}
	},
	capabilities = jdtls.extendedClientCapabilities,
})
