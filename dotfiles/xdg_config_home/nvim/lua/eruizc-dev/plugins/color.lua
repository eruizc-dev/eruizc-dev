return {
	{
		'Mofiqul/dracula.nvim',
		lazy = false,
		priority = 1000,
		opts = { transparent_bg = true },
		config = function(_, opts)
			require'dracula'.setup(opts)
			vim.cmd [[colorscheme dracula]]
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		version = false, -- last release is way too old and doesn't work on Windows
		build = ':TSUpdate',
		event = { 'BufReadPost', 'BufNewFile' },
		cmd = { 'TSUpdateSync' },
		dependencies = 'williamboman/mason.nvim',
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		},
		config = function(_, _opts)
			require'eruizc-dev.utils.mason'.ensure_installed({ 'tree-sitter-cli' })
		end
	}
}
