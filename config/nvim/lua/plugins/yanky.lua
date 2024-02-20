return {
	"gbprod/yanky.nvim",
	dependencies = nil,
	opts = { ring = { storage = "shada" } },
	keys = {
		{ "<leader>p", false },
		{
			"<leader>y",
			function()
				require("telescope").extensions.yank_history.yank_history({})
			end,
			desc = "Open Yank History",
		},
	},
}
