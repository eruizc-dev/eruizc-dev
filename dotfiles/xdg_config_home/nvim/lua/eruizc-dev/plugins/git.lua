return {
	{
		'tpope/vim-fugitive',
		cmd = {
			'Git',
			'Gvdiffsplit',
		}
	},
	{
		'rhysd/git-messenger.vim',
		cmd = 'GitMessenger',
		keys = {
			{ '<leader>blame', '<cmd>GitMessenger<cr>', desc = 'Git blame current line' },
		},
	},
}
