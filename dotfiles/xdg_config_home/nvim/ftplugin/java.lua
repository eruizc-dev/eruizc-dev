vim.cmd[[set tabstop=4]]

require'jdtls'.start_or_attach({
	cmd = {
		vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
		('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
	},
	init_options = {
		bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', 1), '\n'),
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
		require'jdtls'.update_project_config()
	end
})
