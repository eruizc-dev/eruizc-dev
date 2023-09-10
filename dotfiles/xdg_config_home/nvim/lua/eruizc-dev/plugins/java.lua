return {
	{
		'mfussenegger/nvim-jdtls',
		ft = 'java',
		dependencies = {
			'mfussenegger/nvim-dap',
			'hrsh7th/cmp-nvim-lsp',
			'williamboman/mason.nvim',
		},
		config = function ()
			require'eruizc-dev.utils.mason'.ensure_installed({ 'jdtls', 'java-test', 'java-debug-adapter' })
		end
	}
}
