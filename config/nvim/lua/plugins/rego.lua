return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "rego" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "regols" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				regols = {},
			},
		},
	},
}
