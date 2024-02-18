return {
	-- This gives a nice layout for commit authoring from CLI invoked git commit
	{
		"rhysd/committia.vim",
		ft = "gitcommit",
	},
	-- Make browsing blame history for lines easier
	{
		"rhysd/git-messenger.vim",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "gitmessengerpopup",
				group = vim.api.nvim_create_augroup("gitmessenger_customize", { clear = true }),
				callback = function(event)
					vim.keymap.set("n", "<C-o>", "o", { buffer = event.buf })
					vim.keymap.set("n", "<C-i>", "O", { buffer = event.buf })
				end,
			})
			vim.g.git_messenger_floating_win_opts = { border = "double" }
		end,
	},
}
