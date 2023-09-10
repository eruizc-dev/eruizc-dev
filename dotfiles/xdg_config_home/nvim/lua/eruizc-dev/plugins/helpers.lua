return {
	{
		'sudormrfbin/cheatsheet.nvim',
		cmd = 'Cheatsheet',
		dependencies = 'nvim-telescope/telescope.nvim',
		keys = {
			{ '<leader>cs', '<cmd>Cheatsheet<cr>', desc = 'Open cheatsheet' }
		},
	},
	{
		'williamboman/mason.nvim',
		cmd = 'Mason',
		opts = {},
	}
}
