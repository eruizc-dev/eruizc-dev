return {
	{
		'suketa/nvim-dap-ruby',
		ft = 'ruby',
		dependencies = {
			'mfussenegger/nvim-dap',
		},
		config = function (_, opts)
			require'dap-ruby'.setup()
		end
	}
}
