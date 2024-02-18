return {
	{
		"RRethy/vim-illuminate",
		opts = function(_, opts)
			vim.list_extend(opts.filetypes_denylist or {}, { "help", "man" })
		end,
	},
	{ "folke/twilight.nvim", config = true },
	{
		"folke/zen-mode.nvim",
		dependencies = {
			{ "folke/twilight.nvim" },
		},
		opts = {
			window = {
				options = {
					-- number = false,
					-- relativenumber = false,
					colorcolumn = "",
					signcolumn = "no",
				},
			},
			plugins = {
				options = {
					laststatus = 0,
				},
				tmux = { enabled = true },
				wezterm = {
					enabled = true,
					font = "+3",
				},
			},
		},
		keys = {
			{ "<C-w>o", "<cmd>ZenMode<cr>" },
		},
	},
	-- Setup the unmapped wipeout equivalent
	{
		"echasnovski/mini.bufremove",

		keys = {
			{
				"<leader>bw",
				function()
					local bd = require("mini.bufremove").wipeout
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Wipeout Buffer",
			},
      -- stylua: ignore
      { "<leader>bW", function() require("mini.bufremove").delete(0, true) end, desc = "Wipeout Buffer (Force)" },
		},
	},
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaRead", "SudaWrite" },
		config = function()
			vim.g.suda_smart_edit = false
		end,
	},
}
