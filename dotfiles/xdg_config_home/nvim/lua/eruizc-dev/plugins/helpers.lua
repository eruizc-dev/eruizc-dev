return {
	{
		'iamcco/markdown-preview.nvim',
		ft = 'markdown',
		build = function()
			vim.fn['mkdp#util#install']()
		end,
		init = function()
			vim.g.mkdp_port = 8080
		end
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
		'williamboman/mason.nvim',
		cmd = { 'Mason', 'MasonLog' },
		opts = {},
	}
}
