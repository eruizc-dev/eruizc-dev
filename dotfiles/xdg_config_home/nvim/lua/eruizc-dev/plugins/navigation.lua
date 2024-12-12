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
			'jvgrootveld/telescope-zoxide',
			'ThePrimeagen/git-worktree.nvim',
		},
		cmd = 'Telescope',
		version = false,
		keys = {
			{ '<leader>p', function() require'telescope.builtin'.find_files{ find_command = { 'rg', '--files', '--hidden', '--no-ignore-global', '-g', '!.git/' }} end, desc = "foo" },
			{ '<leader>P', function() require'telescope.builtin'.grep_string{ prompt_title='Rip & Tear', search='' } end, desc = "foo" },
			{ '<leader>con', function() require'telescope.builtin'.find_files{ prompt_title='Configuration', cwd='~/.config/nvim' } end, desc = "foo" },
			{ '<leader>z', function() require'telescope'.extensions.zoxide.list() end, desc = "foo" },
			{ '<leader>k', function() require'telescope.builtin'.help_tags() end, desc = "foo" },
			{ 'gr', function() require'telescope.builtin'.lsp_references() end, desc = "foo" },
			{ 'gd', function() require'telescope.builtin'.lsp_definitions() end, desc = "foo" },
			{ 'gi', function() require'telescope.builtin'.lsp_implementations() end, desc = "foo" },
		},
		config = function()
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
					['git_worktree'] = {},
					['zoxide'] = {},
					['zf-native'] = {
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
