return {
	{
		'tpope/vim-sleuth',
		event = { 'BufReadPre', 'BufNewFile' },
	},
	{
		'iamcco/markdown-preview.nvim',
		ft = 'markdown',
		build = function()
			vim.fn['mkdp#util#install']()
		end,
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
	{
		'williamboman/mason.nvim',
		cmd = { 'Mason', 'MasonLog' },
		opts = {
			registries = {
				'github:nvim-java/mason-registry',
				'github:mason-org/mason-registry',
			},
		},
	}
}
