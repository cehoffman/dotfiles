return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "golangci-lint" })
		end,
	},
	{ "neovim/nvim-lspconfig", opts = {
		servers = {
			golangci_lint_ls = {},
		},
	} },
	-- opts = function(_, opts)
	-- 	-- Update configuration for change of where gofumpt lives in gopls. At some
	-- 	-- point in time the upstream will reflect this change.
	-- 	-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/go.lua#L24
	-- 	opts.servers.gopls.settings.gopls.formatting = { gofumpt = true }
	-- 	opts.servers.gopls.settings.gopls.gofumpt = nil
	-- end,
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			for i, source in ipairs(opts.sources) do
				-- Delegate formatting to gopls
				if source == nls.builtins.formatting.gofumpt then
					table.remove(opts.sources, i)
				end
				-- Delegate goimport to conform
				if source == nls.builtins.formatting.goimports then
					table.remove(opts.sources, i)
				end
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				-- Default includfes gofumpt, but gopls handles that
				go = { "goimports" },
			},
		},
	},
}
