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
			ensure_installed = {
				--'goimports', 'gofumpt', 'gomodifytags', 'impl', 'delve', -- Golang
				--'jdtls', 'java-test', 'java-debug-adapter'  -- Java
			},
			registries = {
				'github:mason-org/mason-registry',
			},
		},
	}
}
