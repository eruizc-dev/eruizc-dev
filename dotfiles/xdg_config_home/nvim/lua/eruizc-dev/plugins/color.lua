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
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = 'williamboman/mason.nvim',
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				'lua',
				'java',
				'ruby',
				'go', 'templ',
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			require'eruizc-dev.utils.mason'.ensure_installed({ 'tree-sitter-cli' })
			require("nvim-treesitter.configs").setup(opts)
		end
	}
}
