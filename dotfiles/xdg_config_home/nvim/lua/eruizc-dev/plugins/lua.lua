return {
	{
		'jbyuki/one-small-step-for-vimkind',
		ft = 'lua',
		dependencies = 'mfussenegger/nvim-dap',
		config = function()
			require'dap'.adapters.nlua = function(callback, config)
				callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
			end
			require'dap'.configurations.lua = {
				{
					type = 'nlua',
					request = 'attach',
					name = 'Attach to running Neovim instance',
				},
			}
		end,
	}
}
