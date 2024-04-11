return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.textobjects.move.goto_next_start = { ["]m"] = "@function.outer", ["]c"] = "@class.outer" }
			opts.textobjects.move.goto_next_end = { ["]M"] = "@function.outer", ["]C"] = "@class.outer" }
			opts.textobjects.move.goto_previous_start = { ["[m"] = "@function.outer", ["[c"] = "@class.outer" }
			opts.textobjects.move.goto_previous_end = { ["[M"] = "@function.outer", ["[C"] = "@class.outer" }
		end,
	},
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
				-- TODO: Thesse exchange mappings don't work on multiple lines in visual mode
				-- If I write a replacement, make it work with count (omap)
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
	{
		"tpope/vim-abolish",
	},
	{
		"jbyuki/venn.nvim",
		config = function()
			vim.keymap.set("n", "<leader>v", function()
				local window = vim.api.nvim_get_current_win()
				local venn_enabled = vim.inspect(vim.w[window].venn_enabled)
				vim.w[window].saved_ve = vim.wo.virtualedit
				if venn_enabled == "nil" then
					vim.w[window].venn_enabled = true
					vim.wo.virtualedit = "all"
					-- draw a line on HJKL keystokes
					vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
					vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
					vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
					vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
					-- draw a box by pressing "f" with visual selection
					vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
				else
					vim.wo.virtualedit = vim.w[window].saved_ve
					vim.api.nvim_buf_del_keymap(0, "n", "J")
					vim.api.nvim_buf_del_keymap(0, "n", "K")
					vim.api.nvim_buf_del_keymap(0, "n", "L")
					vim.api.nvim_buf_del_keymap(0, "n", "H")
					vim.api.nvim_buf_del_keymap(0, "v", "f")
					vim.w[window].venn_enabled = nil
				end
			end, { noremap = true, desc = "Toggle diagram mode" })
		end,
	},
	{
		"godlygeek/tabular",
		lazy = false,
	},
	{
		"AndrewRadev/splitjoin.vim",
		event = "VeryLazy",
		config = function()
			vim.g.splitjoin_align = 1
			vim.g.splitjoin_normalize_whitespace = 1
			-- Overwrite mappings so they have descriptions
			vim.keymap.set("n", "gS", "<Plug>SplitjoinSplit", { desc = "Split construct" })
			vim.keymap.set("n", "gJ", "<Plug>SplitjoinJoin", { desc = "Join construct" })
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter.configs").setup({ endwise = { enable = true } })
		end,
	},
	{ "simrat39/symbols-outline.nvim", opts = { auto_close = true } },
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaRead", "SudaWrite" },
		config = function()
			vim.g.suda_smart_edit = false
		end,
	},
	{
		"tpope/vim-projectionist",
		init = function()
			vim.g.projectionist_heuristics = {
				["mix.exs"] = {
					["lib/*.ex"] = {
						alternate = "test/{}_test.exs",
						type = "lib",
					},
					["test/*_test.exs"] = {
						alternate = "lib/{}.ex",
						type = "unittest",
					},
					["mix.exs"] = {
						type = "mix",
					},
				},
				["go.mod"] = {
					["*.go"] = {
						type = "go",
						alternate = "{}_test.go",
						template = {
							"package {dirname|basename}",
						},
					},
					["*_test.go"] = {
						type = "test",
						alternate = "{}.go",
						template = {
							"package {dirname|basename}_test",
						},
					},
					["go.mod"] = {
						type = "mod",
					},
				},
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatting = {
				-- Default is 3s, but goimports for examples takes forever
				timeout_ms = 100000,
			},
		},
	},
}
