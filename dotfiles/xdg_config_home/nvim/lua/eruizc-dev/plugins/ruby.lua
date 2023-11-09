return {
	{
		'suketa/nvim-dap-ruby',
		ft = 'ruby',
		dependencies = {
			'mfussenegger/nvim-dap',
			{ 'williamboman/mason.nvim', opts = {} }
		},
		config = function (_, opts)
			require'dap-ruby'.setup()
		end
	}
}
