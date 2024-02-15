return {

	{
		"vim-scripts/scratch.vim",
		cmd = "Sscratch",
		keys = {
			{ "<leader><Tab>", ":Sscratch<CR><C-W>J:resize 13<CR>", desc = "Open scratch pad" },
		},
		config = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("cehoffman_scratch", { clear = true }),
				pattern = "__Scratch__",
				callback = function()
					vim.bo.buflisted = false
					vim.keymap.set("n", "<leader><Tab>", ":q<CR>", { buffer = 0, desc = "Close scratch pad" })
				end,
			})
		end,
		enabled = false,
	},
	{
		"MunifTanjim/nui.nvim",
		---@diagnostic disable-next-line: unused-local
		config = function(_, opts)
			local Split = require("nui.split")
			local event = require("nui.utils.autocmd").event

			local split = Split({
				relative = "editor",
				position = "bottom",
				size = "20%",
				buf_options = {
					modifiable = true,
					readonly = false,
					buflisted = false,
					filetype = "scratch",
					-- buftype = "prompt",
					-- filetype = "nui",
				},
				win_options = {
					signcolumn = "no",
					wrap = false,
					number = false,
					relativenumber = false,
				},
			})

			-- mount/open the component
			split:mount()
			split:hide()
			local win_id

			vim.keymap.set("n", "<leader><tab>", function()
				win_id = vim.api.nvim_get_current_win()
				split:show()
			end, { desc = "Show scratch window" })

			-- unmount component when cursor leaves buffer
			split:map("n", "<leader><tab>", function()
				split:hide()
				vim.api.nvim_set_current_win(win_id)
			end, { desc = "Hide scratch window" })

			split:on(event.BufLeave, function()
				split:hide()
			end)
		end,
	},
}
