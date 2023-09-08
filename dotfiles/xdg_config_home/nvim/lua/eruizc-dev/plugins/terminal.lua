return {
	'voldikss/vim-floaterm',
	cmd = { 'FloatermNew', 'FloatermPrev', 'FloatermNext' },
	keys = {
		-- Terminal controls
		{ '<C-q>', '<cmd>FloatermHide!<cr>', mode = 'n', desc = 'Hide current terminal'},
		{ '<C-q>', '<cmd>FloatermHide!<cr>', mode = 't', desc = 'Hide current terminal' },
		{ '<C-l>', '<cmd>FloatermPrev<cr>', mode = 't', desc = 'Go to next terminal' },
		{ '<C-h>', '<cmd>FloatermNext<cr>', mode = 't', desc = 'Go to previous terminal' },
		-- Terminals
		{ '<C-a>', '<cmd>FloatermToggle A<CR>', mode = 'n', desc = 'Open terminal 1' },
		{ '<C-s>', '<cmd>FloatermToggle S<CR>', mode = 'n', desc = 'Open terminal 2' },
		{ '<C-d>', '<cmd>FloatermToggle D<CR>', mode = 'n', desc = 'Open terminal 3' },
		{ '<C-f>', '<cmd>FloatermToggle F<CR>', mode = 'n', desc = 'Open terminal 4' },
		{ '<C-a>', '<cmd>FloatermToggle A<CR>', mode = 't', desc = 'Open terminal 1' },
		{ '<C-s>', '<cmd>FloatermToggle S<CR>', mode = 't', desc = 'Open terminal 2' },
		{ '<C-d>', '<cmd>FloatermToggle D<CR>', mode = 't', desc = 'Open terminal 3' },
		{ '<C-f>', '<cmd>FloatermToggle F<CR>', mode = 't', desc = 'Open terminal 4' },
		-- Tui
		{ '<leader>lg', '<cmd>FloatermNew --title=lazygit --autoclose=2 lazygit<CR>', desc = 'Open lazygit' },
	},
	init = function()
		vim.g.floaterm_width = 0.9
		vim.g.floaterm_height = 0.9
	end
}
