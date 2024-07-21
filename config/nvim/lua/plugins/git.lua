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
	-- {
	-- 	"ThePrimeagen/git-worktree.nvim",
	-- 	keys = {
	-- 		{
	-- 			"<leader>gt",
	-- 			":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
	-- 			desc = "Switch to git worktree",
	-- 		},
	-- 		{
	-- 			"<leader>gT",
	-- 			":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
	-- 			desc = "Create git worktree",
	-- 		},
	-- 		{
	-- 			"<leader>gp",
	-- 			function()
	-- 				local branch = require("neogit.lib.git.branch").current()
	-- 				-- local branch = vim.fn.FugitiveHead()
	-- 				local Job = require("plenary.job")
	-- 				local stdout, code = Job:new({
	-- 					"gh",
	-- 					"pr",
	-- 					"list",
	-- 					"--head",
	-- 					branch,
	-- 					"--state",
	-- 					"open",
	-- 					"--limit",
	-- 					"1",
	-- 					"--json",
	-- 					"url",
	-- 					"--jq",
	-- 					".[] | .url",
	-- 					cwd = vim.loop.cwd(),
	-- 				}):sync()
	-- 				stdout = table.concat(stdout, "")
	-- 				if code == 0 then
	-- 					vim.fn.execute("!open " .. vim.fn.shellescape(stdout) .. " &>/dev/null")
	-- 				else
	-- 					vim.ui.select({ "Yes", "No" }, { prompt = "Create PR?" }, function(idx)
	-- 						if idx == 1 then
	-- 							vim.notify("No open PR found for " .. branch, vim.log.levels.INFO)
	-- 							vim.fn.execute("!gh pr create --fill-first --web &>/dev/null")
	-- 						end
	-- 					end)
	-- 				end
	-- 			end,
	-- 			desc = "Open related pull request",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		update_on_change = true,
	-- 		update_on_change_command = "e .",
	-- 		confirm_telescope_deletions = true,
	-- 		autopush = false,
	-- 		bare_as_non_bare = true,
	-- 	},
	-- 	config = function(_, opts)
	-- 		local gwt = require("git-worktree")
	-- 		gwt.setup(opts)
	--
	-- 		-- Automate sparse checkout setup
	-- 		gwt.on_tree_change(function(op, metadata)
	-- 			local abspath = gwt.get_worktree_path(metadata.path)
	-- 			if op == gwt.Operations.Create then
	-- 				-- The worktree exists, but the working directory is not yet switched
	-- 				local Job = require("plenary.job")
	-- 				local init_sparse_checkout = Job:new({
	-- 					"git",
	-- 					"sparse-checkout",
	-- 					"init",
	-- 					cwd = abspath,
	-- 				})
	-- 				local _, code = init_sparse_checkout:sync()
	-- 				if code ~= 0 then
	-- 					vim.notify("Failed to init sparse-checkout for " .. metadata.path, vim.log.levels.ERROR)
	-- 				end
	-- 			elseif op == gwt.Operations.Delete then
	-- 				local wipeout = require("mini.bufremove").wipeout
	--
	-- 				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
	-- 					local bufpath = vim.fn.expand(string.format("#%d:p", buf))
	-- 					---@diagnostic disable-next-line: unused-local
	-- 					local startindex, _endindex = string.find(bufpath, abspath, 1, true)
	-- 					if startindex == 1 then
	-- 						wipeout(buf)
	-- 					end
	-- 				end
	-- 			end
	-- 		end)
	--
	-- 		require("lazyvim.util").on_load("telescope.nvim", function()
	-- 			require("telescope").load_extension("git_worktree")
	-- 		end)
	-- 	end,
	-- },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		keys = {
			{ "<leader>gs", "<cmd>Neogit kind=split_above<CR>", desc = "Git status" },
			{
				"<leader>gc",
				function()
					require("neogit").action("commit", "commit")()
				end,
				desc = "Git commit",
			},
			{
				"<leader>gl",
				function()
					require("neogit").action("log", "log_current")()
				end,
				desc = "Git log",
			},
		},
		cmd = { "Neogit" },
		opts = {
			disable_signs = true,
			graph_style = "unicode",
			telescope_sorter = function()
				return require("telescope").extensions.fzf.native_fzf_sorter()
			end,
			kind = "split_above",
			-- commit_editor = {
			-- 	kind = "floating",
			-- },
		},
	},
	-- {
	-- 	"tpope/vim-fugitive",
	-- 	enabled = false,
	-- 	init = function()
	-- 		local utils = require("cehoffman.util")
	-- 		local augroup = utils.augroup("git")
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			group = augroup,
	-- 			pattern = "gitrebase",
	-- 			callback = function(event)
	-- 				vim.keymap.set("n", "p", "<cmd>Pick<CR>", { buffer = event.buf, desc = "Pick commit for rebase" })
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"s",
	-- 					"<cmd>Squash<CR>",
	-- 					{ buffer = event.buf, desc = "Squash commit with one above it" }
	-- 				)
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"e",
	-- 					"<cmd>Edit<CR>",
	-- 					{ buffer = event.buf, desc = "Edit commit during rebase" }
	-- 				)
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"r",
	-- 					"<cmd>Reword<CR>",
	-- 					{ buffer = event.buf, desc = "Reword commit message during rebase" }
	-- 				)
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"f",
	-- 					"<cmd>Fixup<CR>",
	-- 					{ buffer = event.buf, desc = "Fixup commit with one above it" }
	-- 				)
	-- 			end,
	-- 		})
	--
	-- 		vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
	-- 			group = augroup,
	-- 			callback = function(event)
	-- 				-- if vim.fn.expand("%:t") == "COMMIT_EDITMSG" then
	-- 				--   vim.opt_local.spell = true
	-- 				-- end
	-- 				vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { buffer = event.buf, desc = "Open git status" })
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"<leader>gc",
	-- 					"<cmd>Git commit<CR>",
	-- 					{ buffer = event.buf, desc = "Commit git state" }
	-- 				)
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"<leader>gw",
	-- 					"<cmd>Gwrite!<CR><cmd>redraw!<CR>",
	-- 					{ buffer = event.buf, desc = "Write file to index" }
	-- 				)
	-- 				vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { buffer = event.buf, desc = "Open git log" })
	-- 			end,
	-- 		})
	--
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			group = augroup,
	-- 			pattern = "gitcommit",
	-- 			callback = function()
	-- 				vim.opt_local.spell = true
	-- 			end,
	-- 		})
	--
	-- 		-- Change working directory to be the repoistory root for all of vim and
	-- 		-- change each buffer to have a working directory of the file directory
	-- 		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	-- 			group = augroup,
	-- 			callback = function(event)
	-- 				if vim.b[event.buf].git_dir ~= nil then
	-- 					vim.cmd([[
	--              silent! Gcd
	--              silent! lcd %:p:h
	--            ]])
	-- 				end
	-- 			end,
	-- 		})
	--
	-- 		vim.cmd.cabbrev("git <C-R>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Git' : 'git')<CR>")
	-- 	end,
	-- },
}
