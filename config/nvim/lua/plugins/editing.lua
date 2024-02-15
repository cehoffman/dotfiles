return {
	{
		"tummetott/unimpaired.nvim",
		opts = {
			default_keymaps = false,
			keymaps = {
				-- bprevious = "[b",
				-- bnext = "]b",
				lprevious = "[l",
				lnext = "]l",
				lfirst = "[L",
				llast = "]L",
				-- cprevious = "[q",
				-- cnext = "]q",
				cfirst = "[Q",
				clast = "]Q",
				previous_file = "[f",
				next_file = "]f",
				blank_above = "[<space>",
				blank_below = "]<space>",
				exchange_above = "[x",
				exchange_below = "]x",
				exchange_section_above = "[x",
				exchange_section_below = "]x",
				toggle_hlsearch = "yoh",
				toggle_spell = "yos",
				toggle_wrap = "yow",
			},
		},
	},

	-- Modify surround mappings to be less onerous to use because flash.nvim is
	-- disabled in this configuration and they conflicted on wanting to use the
	-- same prefix `s`.
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`
			},
		},
		dependencies = {
			"folke/which-key.nvim",
			opts = function(_, opts)
				opts.defaults["s"] = { name = "+surround" }
			end,
		},
	},
}
