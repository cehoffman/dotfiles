return {
	{ "towolf/vim-helm", ft = "helm" },
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "helm-ls" })
		end,
	},
	{
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					helm_ls = { -- This is for the mapping in nvim-lspconfig
						-- settings = { -- This is passed to the NVIM LSP
						-- 	["helm-ls"] = { -- This is the actual LSP name  within the LSP
						-- 		yamlls = {
						-- 			enabled = true,
						-- 			config = { -- This is passthrough to the LSP launched by Helm LSP
						-- 				schemaStore = {
						-- 					url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/_definitions.json",
						-- 				},
						-- 			},
						-- 		},
						-- 	},
						-- },
					},
				},
			},
		},
	},
}
