return {
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		dependencies = { 'nvim-tree/nvim-web-devicons', },
		opts = {
			options = {
				theme = 'dracula',
				icons_enabled = true,
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				globalstatus = true,
			},
			sections = {
				lualine_a = { 'branch' },
				lualine_b = {
				},
				lualine_c = {
					{ 'filetype', icon_only = true },
					{ 'filename', path = 1, symbols = { modified = '', readonly = '', unnamed = '', newfile = '' } }
				},
				lualine_x = {{
					'diagnostics',
					always_visible = true,
					sources = { 'nvim_workspace_diagnostic' },
					sections = { 'info', 'warn', 'error' }
				}},
				lualine_y = {{
					'diagnostics',
					always_visible = true,
					sources = { 'nvim_diagnostic' },
					sections = { 'warn', 'error' }
				}},
				lualine_z = { 'encoding', 'fileformat' },
			},
		}
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		version = '2',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {
			char = '▏',
			show_trailing_blankline_indent = false,
			show_current_context = true,
			show_current_context_start = false,
			filetype_exclude = {
				'help',
				'alpha',
				'dashboard',
				'neo-tree',
				'Trouble',
				'lazy',
				'mason',
				'notify',
				'toggleterm',
				'lazyterm',
			},
		},
	}
}
