return {
	{
		'nvim-neotest/neotest',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			'antoinemadec/FixCursorHold.nvim',
			-- Adapters
			'nvim-neotest/neotest-go',
			'olimorris/neotest-rspec',
			'andy-bell101/neotest-java',
		},
		opts = function()
			return {
				adapters = {
					require'neotest-go',
					require'neotest-rspec',
					require'neotest-java',
				},
				status = { virtual_text = true },
				output = { open_on_run = true },
			}
		end,
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace('neotest')
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						return diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
					end,
				},
			}, neotest_ns)

			require('neotest').setup(opts)
		end,
		keys = {
			{ '<leader>tt', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run File' },
			{ '<leader>tT', function() require('neotest').run.run(vim.loop.cwd()) end, desc = 'Run All Test Files' },
			{ '<leader>tr', function() require('neotest').run.run() end, desc = 'Run Nearest' },
			{ '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle Summary' },
			{ '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end, desc = 'Show Output' },
			{ '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle Output Panel' },
			{ '<leader>tS', function() require('neotest').run.stop() end, desc = 'Stop' },
		},
	}
}
