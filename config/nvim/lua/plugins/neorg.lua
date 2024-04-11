return {
	"nvim-neorg/neorg",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"vhyrro/luarocks.nvim",
			priority = 1000,
			config = true,
		},
	},
	version = "*",
	lazy = true, -- enable lazy load
	ft = "norg", -- lazy load on file type
	cmd = "Neorg", -- lazy load on command
	opts = {
		load = {
			["core.clipboard.code-blocks"] = {}, -- Strip leading whitespace on copy
			["core.esupports.hop"] = {}, -- Link following on <CR> and autofixing
			-- ["core.esupports.indent"] = {}, -- Note reformatting
			["core.esupports.metagen"] = {
				config = {
					type = "auto", -- Always generate metadata
				},
			},
			["core.itero"] = {}, -- Continue contex type to next line with <A-CR>
			["core.journal"] = {
				config = {
					journal_folder = "dailies",
					workspace = "personal",
				},
			},
			["core.pivot"] = {},
			["core.promo"] = {},
			["core.qol.toc"] = {},
			["core.qol.todo_items"] = {},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.export"] = {},
			["core.export.markdown"] = {
				config = {
					extensions = { "todo-items-basic", "metadata" },
				},
			},
			["core.summary"] = {},
			["core.ui.calendar"] = {},
			-- This module is possibly not ready
			-- https://github.com/nvim-neorg/neorg/wiki/Core-Presenter
			-- ["core.presenter"] = {
			--   zen_mode = "zen-mode",
			-- },
			["core.defaults"] = {}, -- Loads default behaviour
			["core.concealer"] = { -- Adds pretty icons to your documents
				config = {
					icon_preset = "diamond",
				},
			},
			["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						personal = vim.fn.expand("~") .. "/Library/Mobile Documents/com~apple~CloudDocs/notes/personal",
						work = vim.fn.expand("~") .. "/Library/Mobile Documents/com~apple~CloudDocs/notes/work",
					},
					default_workspace = "personal",
				},
			},
		},
	},
}
