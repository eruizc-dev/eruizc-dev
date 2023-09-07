return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			-- Required
			'nvim-lua/plenary.nvim',
			-- Optional
			'nvim-web-devicons',
			'nvim-treesitter/nvim-treesitter',
			-- Extensions
			'natecraddock/telescope-zf-native.nvim',
			'jvgrootveld/telescope-zoxide'
		},
		cmd = 'Telescope',
		version = false,
		config = function(_, opts)
			require'telescope'.setup {
				defaults = {
					prompt_prefix = " ",
					color_devicons = true,
					layout_strategy = "vertical",
					layout_config = {
						width = 0.80,
						height = 0.90,
						preview_cutoff = 0.5,
						vertical = {
							preview_height = 0.60,
							prompt_position = "bottom",
						},
						horizontal = {
							preview_width = 0.5,
							prompt_position = "bottom",
						}
					},
					mappings = {
						i = {
							["<ESC>"] = require'telescope.actions'.close,
							["<C-j>"] = require'telescope.actions'.move_selection_next,
							["<C-k>"] = require'telescope.actions'.move_selection_previous,
							["<C-h>"] = require'telescope.actions'.preview_scrolling_up,
							["<C-l>"] = require'telescope.actions'.preview_scrolling_down,
						},
					},
				},
				extensions = {
					["zf-native"] = {
						file = {
							enable = true,
							highlight_results = true,
							match_filename = true,
						},
						generic = {
							enable = true,
							highlight_results = true,
							match_filename = false,
						},
					}
				}
			}

			-- Load extensions
			require'telescope'.load_extension'zf-native'
			require'telescope'.load_extension'zoxide'
		end,
	},
	{
		'ThePrimeagen/harpoon',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ "<leader>m", function() require'harpoon.mark'.add_file() end, desc = 'Add file to harpoon' },
			{ "<leader>'", function() require'harpoon.ui'.toggle_quick_menu() end, desc = 'Open harpoon quick menu ' },
			{ "'a", function() require'harpoon.ui'.nav_file(1) end, desc = 'Jump to harpoon file 1' },
			{ "'s", function() require'harpoon.ui'.nav_file(2) end, desc = 'Jump to harpoon file 2' },
			{ "'d", function() require'harpoon.ui'.nav_file(3) end, desc = 'Jump to harpoon file 3' },
			{ "'f", function() require'harpoon.ui'.nav_file(4) end, desc = 'Jump to harpoon file 4' },
		}
	}
}
