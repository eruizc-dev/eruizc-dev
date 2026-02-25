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
		lazy = false,
		build = ':TSUpdate',
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				'lua',
				'java',
				'ruby',
				'go', 'gomod', 'gowork', 'gosum', 'templ',
				'markdown', 'markdown_inline',
				'json', 'json5',
				'yaml'
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		},
	}
}
