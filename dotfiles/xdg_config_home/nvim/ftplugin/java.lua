local function path(package_name)
	return require'mason-registry'.get_package(package_name):get_install_path()
end

vim.cmd[[set tabstop=4]]

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require'lint'.try_lint()
  end,
})

require'jdtls'.start_or_attach({
	cmd = {
		'jdtls',
		'-data',
		vim.fn.expand('$HOME') .. '/.cache/jdtls-workspace',
		'--jvm-arg=-javaagent:' .. path'jdtls' .. '/lombok.jar',
	},
	init_options = {
		bundles = require'eruizc-dev.utils.list'.join(
			vim.fn.glob(path'java-debug-adapter' .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', 1) ,
			vim.split(vim.fn.glob(path'java-test' .. '/extension/server/*.jar', 1), "\n")
		)
	},
	settings = {
		java = {
			-- Maybe uncomment this later, when lombok 1.31.1 is released? It seems that this overries the -javaagent in the script
			--jdt = {
			--	ls = {
			--		lombokSupport = {
			--			enabled = true
			--		}
			--	}
			--},
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

