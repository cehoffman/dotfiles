return {
	{ "ryanoasis/vim-devicons" },
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
					number = false,
					relativenumber = false,
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
	-- For edgy to place help and man on right side of workspace
	{
		"folke/edgy.nvim",
		opts = function(_, opts)
			local removal_idxs = {}
			opts.bottom = opts.bottom or {}
			for i, win in ipairs(opts.bottom) do
				-- Swamp help window to be on the right
				if win.ft == "help" then
					table.remove(opts.bottom, i)
				end
			end
			for i = #removal_idxs, 1, -1 do
				table.remove(opts.bottom, removal_idxs[i])
			end

			opts.left = opts.left or {}
			for i, win in ipairs(opts.left) do
				-- Remove neo-tree since it is disabled
				if win.ft == "neo-tree" or win == "neo-tree" then
					vim.list_extend(removal_idxs, { i })
				end
			end

			for i = #removal_idxs, 1, -1 do
				table.remove(opts.left, removal_idxs[i])
			end

			opts.right = vim.list_extend(opts.right or {}, {
				{
					ft = "help",
					size = { width = 80 },
					-- don't open help files in edgy that we're editing
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{
					ft = "man",
					size = { width = 80 },
				},
			})

			if opts.right ~= nil then
				for i, win in ipairs(opts.right) do
					-- Swamp symbol viewer to be on left
					if win.ft == "aerial" or win.ft == "Outline" then
						table.insert(opts.left, table.remove(opts.right, i))
					end
				end
			end
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "man" },
				callback = function(args)
					require("ibl").setup_buffer(args.buf, { enabled = false })
				end,
			})
		end,
	},
}
