return {
	"epwalsh/obsidian.nvim",
	version = "*",
	ft = "markdown",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "ObsidianToday", "ObsidianNew", "ObsidianOpen", "ObsidianSearch", "ObsidianWorkspace" },
	opts = {
		workspaces = {
			{
				name = "world",
				path = vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/World",
			},
		},
		notes_subdir = "3 - Resources/notes",
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true, desc = "Follow link" },
			},
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
		vim.keymap.set("v", "<C-l>", ":ObsidianLink<CR>", { desc = "Link to note" })
	end,
}
