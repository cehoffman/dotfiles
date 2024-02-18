return {
	{
		"RRethy/vim-illuminate",
		opts = function(_, opts)
			vim.list_extend(opts.filetypes_denylist or {}, { "help", "man" })
		end,
	},
	{
		"folke/zen-mode.nvim",
		dependencies = {
			{ "folke/twilight.nvim", opts = {} },
		},
		opts = {
			window = {
				options = {
					-- number = false,
					-- relativenumber = false,
					colorcolumn = "",
					signcolumn = "no",
				},
			},
			plugins = {
				options = {
					laststatus = 0,
				},
				tmux = { enabled = true },
				wezterm = {
					enabled = true,
					font = "+3",
				},
			},
		},
		keys = {
			{ "<C-w>o", "<cmd>ZenMode<cr>" },
		},
	},
}
