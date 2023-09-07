return {
	{
		'olexsmir/gopher.nvim',
		ft = 'go',
		dependencies = { 'mfussenegger/nvim-dap' },
		config = function (_, opts)
			require'gopher.dap'.setup(opts)
		end
	}
}
