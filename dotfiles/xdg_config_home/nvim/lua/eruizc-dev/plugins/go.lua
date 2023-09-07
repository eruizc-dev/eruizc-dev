return {
	{
		'olexsmir/gopher.nvim',
		ft = 'go',
		dependencies = {
			'mfussenegger/nvim-dap',
			{ 'williamboman/mason.nvim', opts = {} }
		},
		config = function (_, opts)
			require'eruizc-dev.utils.mason'.ensure_installed({ 'gopls', 'delve' })
			require'gopher.dap'.setup(opts)
		end
	}
}
