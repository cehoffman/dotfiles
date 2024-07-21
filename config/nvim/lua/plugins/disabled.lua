return {
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters_by_ft.markdown = nil
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			for i, source in ipairs(opts.sources) do
				if source.name == "markdownlint" then
					table.remove(opts.sources, i)
					break
				end
			end
		end,
	},
	-- { "lukas-reineke/headlines.nvim", enabled = false },
	{ "akinsho/bufferline.nvim", enabled = false },
	{ "folke/flash.nvim", enabled = false },
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ "<leader>e", group = "edit" },
				-- { "<leader><tab>", hidden = true },
				-- { "<leader>w", hidden = true },
				{ "<leader>n", group = "new" },
			},
		},
	},
}
