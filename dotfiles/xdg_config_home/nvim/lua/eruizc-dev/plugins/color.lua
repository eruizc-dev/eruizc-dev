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
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"comment",
				"css",
				"csv",
				"diff",
				"dockerfile",
				"dot",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"html",
				"ini",
				"java",
				"javascript",
				"jq",
				"jsdoc",
				"json",
				"jsonc",
				"latex",
				"lua",
				"luadoc",
				"luap",
				"make",
				"markdown",
				"markdown_inline",
				"nix",
				"regex",
				"ruby",
				"rust",
				"sql",
				"toml",
				"tsx",
				"typecript",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
	}
}
