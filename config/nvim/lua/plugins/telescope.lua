return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = {
			layout_strategy = "vertical",
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
		{ "<leader>gc", false },
		{ "<leader>gs", false },
		{
			"<leader>p",
			function(...)
				local root_dir = vim.fs.find(".git", { path = vim.loop.cwd(), upward = true })[1]
				if root_dir then
					root_dir = vim.fs.dirname(root_dir)
				else
					root_dir = false
				end
				-- require("lazyvim.util").telescope("files", vim.tbl_deep_extend("force", ... or {}, { cwd = root_dir }))()
				require("telescope.builtin")["find_files"]({ cwd = root_dir })
			end,
			desc = "Find files (git root or local)",
		},
		-- { '<leader>s', "<cmd>Telescope registers<cr>", desc = "Registers" },
	},
}
