return {
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.preselect = cmp.PreselectMode.None
			opts.completion.completeopt = "menu,menuone,noinsert,noselect"
			-- Overwrite distro completely
			opts.mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				-- ["<ESC>"] = cmp.mapping.abort(),
				-- Complete using the selected item or first item if nothing selected
				["<C-e>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				-- Accept completion only if something is selected
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				-- Replaces adjacent text during completion
				["<S-CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				-- This should not be needed because the <cr> mamppings have select=false
				-- ["<C-CR>"] = function(fallback)
				-- 	cmp.abort()
				-- 	fallback()
				-- end,
			})
			opts.window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			}
		end,
	},
}
