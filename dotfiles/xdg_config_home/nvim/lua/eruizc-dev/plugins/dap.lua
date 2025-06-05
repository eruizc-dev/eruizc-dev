return {
	{
		'mfussenegger/nvim-dap',
		lazy = true,
		dependencies = { 'theHamsta/nvim-dap-virtual-text' },
		config = function()
			vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
		end,
	},
	{
		'rcarriga/nvim-dap-ui',
		lazy = true,
		dependencies = {
			'mfussenegger/nvim-dap',
			'theHamsta/nvim-dap-virtual-text',
		},
		config = function(_, opts)
			local dap = require('dap')
			local dapui = require('dapui')
			dapui.setup(opts)
			dap.listeners.after.event_initialized['dapui_config'] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated['dapui_config'] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited['dapui_config'] = function()
				dapui.close({})
			end
		end,
		keys = {
			{ '<leader>db', function() require'dap'.toggle_breakpoint() end },
			{ '<leader>dc', function() require'dap'.continue() end },
			{ '<leader>do', function() require'dap'.step_over() end },
			{ '<leader>di', function() require'dap'.step_into() end }
		},
	},
	{
		'theHamsta/nvim-dap-virtual-text',
		lazy = true,
		opts = {}
	}
}
