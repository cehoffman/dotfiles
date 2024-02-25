return {
	-- This gives a nice layout for commit authoring from CLI invoked git commit
	{
		"rhysd/committia.vim",
		ft = "gitcommit",
	},
	-- Make browsing blame history for lines easier
	{
		"rhysd/git-messenger.vim",
		keys = {
			-- This doesn't actually cause lazy loading, it is purely here for better
			-- which-key descriptions
			{ "<leader>gm", "<Plug>(git-messenger)", desc = "Open git history at line" },
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "gitmessengerpopup",
				group = vim.api.nvim_create_augroup("gitmessenger_customize", { clear = true }),
				callback = function(event)
					vim.keymap.set("n", "<C-o>", "o", { buffer = event.buf })
					vim.keymap.set("n", "<C-i>", "O", { buffer = event.buf })
				end,
			})
			vim.g.git_messenger_floating_win_opts = { border = "double" }
		end,
	},
	{
		"tpope/vim-fugitive",
		init = function()
			local utils = require("cehoffman.util")
			local augroup = utils.augroup("git")
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup,
				pattern = "gitrebase",
				callback = function(event)
					vim.keymap.set("n", "p", "<cmd>Pick<CR>", { buffer = event.buf, desc = "Pick commit for rebase" })
					vim.keymap.set(
						"n",
						"s",
						"<cmd>Squash<CR>",
						{ buffer = event.buf, desc = "Squash commit with one above it" }
					)
					vim.keymap.set(
						"n",
						"e",
						"<cmd>Edit<CR>",
						{ buffer = event.buf, desc = "Edit commit during rebase" }
					)
					vim.keymap.set(
						"n",
						"r",
						"<cmd>Reword<CR>",
						{ buffer = event.buf, desc = "Reword commit message during rebase" }
					)
					vim.keymap.set(
						"n",
						"f",
						"<cmd>Fixup<CR>",
						{ buffer = event.buf, desc = "Fixup commit with one above it" }
					)
				end,
			})

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
				group = augroup,
				callback = function(event)
					-- if vim.fn.expand("%:t") == "COMMIT_EDITMSG" then
					--   vim.opt_local.spell = true
					-- end
					vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { buffer = event.buf, desc = "Open git status" })
					vim.keymap.set(
						"n",
						"<leader>gc",
						"<cmd>Git commit<CR>",
						{ buffer = event.buf, desc = "Commit git state" }
					)
					vim.keymap.set(
						"n",
						"<leader>gw",
						"<cmd>Gwrite!<CR><cmd>redraw!<CR>",
						{ buffer = event.buf, desc = "Write file to index" }
					)
					vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { buffer = event.buf, desc = "Open git log" })
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = augroup,
				pattern = "gitcommit",
				callback = function()
					vim.opt_local.spell = true
				end,
			})

			-- Change working directory to be the repoistory root for all of vim and
			-- change each buffer to have a working directory of the file directory
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				group = augroup,
				callback = function(event)
					if vim.b[event.buf].git_dir ~= nil then
						vim.cmd([[
              silent! Gcd
              silent! lcd %:p:h
            ]])
					end
				end,
			})

			vim.cmd.cabbrev("git <C-R>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Git' : 'git')<CR>")
		end,
	},
}
