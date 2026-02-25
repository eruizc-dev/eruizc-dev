return {
	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = 'tpope/vim-dadbod',
		cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer', },
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_table_helpers = {
				sqlite = {
					Describe = "PRAGMA table_info('{table}');"
				}
			}
		end,
	},
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
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
				---@type ibl.config
				opts = { },
    }
}
