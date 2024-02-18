return {
	-- "hrsh7th/cmp-nvim-lsp",
	-- "hrsh7th/cmp-buffer",
	-- "hrsh7th/cmp-path",
	-- "hrsh7th/cmp-cmdline",
	-- "quangnguyen30192/cmp-nvim-ultisnips",
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.mapping["<C-e>"] = cmp.mapping.confirm({ select = true })
			opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })
			opts.window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			}
		end,
	},
}
