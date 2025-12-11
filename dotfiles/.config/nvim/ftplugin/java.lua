vim.cmd[[setlocal tabstop=4]]
vim.cmd[[setlocal colorcolumn=120]]

local jdtls_enabled, jdtls = pcall(require, 'jdtls')

if not jdtls_enabled then
	return
end

local bundles = { vim.fn.glob('$JAVA_DEBUG/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar', 1) }
local java_test_bundles = vim.split(vim.fn.glob('$JAVA_TEST/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar', 1), "\n")
local excluded = { 'com.microsoft.java.test.runner-jar-with-dependencies.jar', 'jacocoagent.jar' }
for _, java_test_jar in ipairs(java_test_bundles) do
  local fname = vim.fn.fnamemodify(java_test_jar, ":t")
  if not vim.tbl_contains(excluded, fname) then
    table.insert(bundles, java_test_jar)
  end
end

jdtls.start_or_attach({
	cmd = { 'jdtls' },
	root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
	init_options = {
		bundles = bundles
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
