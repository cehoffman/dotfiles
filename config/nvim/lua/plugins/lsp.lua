return {
	{ "folke/neoconf.nvim", opts = { import = { vscode = false } } },
	{
		"neovim/nvim-lspconfig",
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			-- change a keymap
			-- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
			-- disable a keymap
			keys[#keys + 1] = { "K", false }
			-- add a keymap
			-- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		-- enabled = false,
		opts = {
			ui = {
				expand = "",
				collapse = "",
				code_action = "➜ ",
			},
			hover = {
				max_width = 0.4,
				max_height = 0.2,
				open_cmd = "!open ",
			},
			lightbulb = {
				virtual_text = false,
				debounce = 550,
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"stevearc/aerial.nvim",
		optional = true,
		opts = {
			-- layout = {
			-- 	default_direction = "right",
			-- 	placement = "edge",
			-- },
			close_automatic_events = {
				"unsupported", -- Close if buffer has no symbol source
			},
			ignore = {
				unlisted_buffers = true,
			},
			close_on_select = true,
		},
	},
	{
		"hedyhli/outline.nvim",
		opts = {
			outline_window = {
				auto_close = true,
				-- auto_jump = true,
			},
		},
	},
}
