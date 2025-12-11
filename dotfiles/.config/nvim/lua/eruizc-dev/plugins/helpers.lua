return {
	{
		'terrastruct/d2-vim',
		ft = 'd2'
	},
	{
		'tpope/vim-sleuth',
		event = { 'BufReadPre', 'BufNewFile' },
	},
	{
		'brianhuster/live-preview.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
		},
	},
	{
		'sudormrfbin/cheatsheet.nvim',
		cmd = 'Cheatsheet',
		dependencies = 'nvim-telescope/telescope.nvim',
		keys = {
			{ '<leader>cs', '<cmd>Cheatsheet<cr>', desc = 'Open cheatsheet' }
		},
	},
	{
		'nvim-lua/plenary.nvim',
		cmd = 'PlenaryBustedDirectory',
	},
}
