return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = {
			mappings = {
				i = {
					-- Keep loading lazy
					["<ESC>"] = function(...)
						require("telescope.actions").close(...)
					end,
				},
			},
		},
	},
	keys = {
		{
			"<leader>o",
			"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
			desc = "Switch Buffer",
		},
		{ "<leader>,", false },
		{ "<leader>p", "<cmd>Telescope find_files<CR>", desc = "Find files" },
		-- { '<leader>s', "<cmd>Telescope registers<cr>", desc = "Registers" },
	},
}
