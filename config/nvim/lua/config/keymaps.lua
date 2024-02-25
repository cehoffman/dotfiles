local cUtils = require("cehoffman.util")
local Util = require("lazyvim.util")

-- Remove default keymaps
-- vim.keymap.del("n", "K")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
-- vim.keymap.del("n", "<leader><tab>")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>w|")
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>ww")
vim.keymap.del("n", "<leader>wd")
-- LazyVim defaults to keeping visual selection and having you use > and < to
-- indent or deindent. Instead remove them and use `.` to repeat instead of
-- continuing to use >, <.
vim.keymap.del("x", ">")
vim.keymap.del("x", "<")

-- Replace ex mode with format
vim.keymap.set({ "n", "v", "o" }, "Q", "gq")

-- Normal mode mappings
vim.keymap.set("n", "<leader>nv", "<C-W>v:enew<cr>", { desc = "New buffer in right vertical", silent = true })
vim.keymap.set("n", "<leader>ns", "<C-W>s:enew<cr>", { desc = "New buffer in below split", silent = true })
vim.keymap.set("n", "<leader>nt", "<cmd>tabnew<CR>", { desc = "New tab", silent = true })
vim.keymap.set("n", "<leader>nT", "<C-W>T", { desc = "New tab from current window" })
vim.keymap.set("n", "<leader><leader>", "<C-^>", { noremap = true, desc = "Go to alternate file" })
vim.keymap.set("n", "<leader>el", ":e <C-R>=expand('%:p:h')<CR>/", { desc = "Edit file relative to current file" })
vim.keymap.set({ "n", "v" }, "<space>", "za", { desc = "Toggle fold" })
vim.keymap.set(
	"n",
	"<leader>xx",
	cUtils.trim_whitespace,
	{ silent = true, noremap = true, desc = "Trim trailing whitespace" }
)
vim.keymap.set("n", "<leader>xw", function()
	cUtils.trim_whitespace()
	vim.cmd.w()
end, { silent = true, noremap = true, desc = "Trim trailing whitespace (write)" })
vim.keymap.set("n", "<leader>w", function()
	local uri = vim.fn.matchstr(
		vim.fn.getline("."),
		"[a-zA-Z]\\+:\\/\\/\\([a-zA-Z0-9_-]\\+\\.\\)\\+[a-zA-Z]\\+\\(\\/[\\.a-zA-Z0-9_-]\\+\\)*\\ze[^\\.]\\?"
	)
	if uri ~= "" then
		vim.notify("Opening " .. uri)
		vim.fn.execute("!open " .. vim.fn.shellescape(uri) .. " &> /dev/null")
	else
		vim.notify("No URI found in line.")
	end
end, { remap = false, desc = "Open URL in current line" })
-- Keep searches in middle of screen
vim.keymap.set("n", "*", "*zzzv", { remap = false })
vim.keymap.set("n", "#", "#zzzv", { remap = false })
vim.keymap.set("n", "n", "nzzzv", { remap = false })
vim.keymap.set("n", "N", "Nzzzv", { remap = false })
vim.keymap.set("n", "<leader>gw", function()
	vim.cmd.write()
	vim.fn.jobstart({ "git", "add", "--force", "--", vim.fn.expand("%") })
end, { remap = false, desc = "Add file to git index" })

-- Insert mode
-- Make killing a line start an undo point
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>", { desc = "Undo line" })
-- Jump over closing pair with a univeral key `;`
vim.keymap.set("i", ";", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	local line = vim.api.nvim_get_current_line()
	local rhPair = {
		[")"] = ")",
		["}"] = "}",
		["]"] = "]",
		['"'] = '"',
		["'"] = "'",
		["`"] = "`",
		[";"] = "<right>",
	}

	-- Look at the character to the right of the cursor
	-- If it is a closing pair, jump over it (using mini.pairs) automatic jump
	-- over when sending the closing pair character. The key we use to signal
	-- jump over, `;`, is not part of mini.pairs so we need to send a right arrow
	-- key movement to jump over it. If not a closing pair send `;`.
	local char = line:sub(pos[2] + 1, pos[2] + 1)
	if rhPair[char] then
		return rhPair[char]
	end
	return ";"
end, { expr = true, remap = true })
-- Easy ISO8601 timestamp insertion
vim.cmd.iabbrev("i8601", "<C-R>=strftime('%Y-%m-%dT%H:%M:%S%z')<CR>")

-- Command mode mappings
vim.keymap.set("c", "<C-a>", "<home>")
vim.keymap.set("c", "<C-e>", "<end>")
vim.keymap.set("c", "%%", "<C-R>=expand('%:p:h')<CR>", { desc = "Fill in directory of current file" })

-- Visual mode mappings
vim.keymap.set("v", "ae", "ggVoG$", { desc = "Select whole file" })
-- With conform.nvim managing use of external formatters, gq will default to using
-- the external formatter. That isn't very useful for comment wrapping as they
-- are unlikely to touch comments. Define Q to use vim formatting.
vim.keymap.set("v", "Q", "gw", { desc = "Format selection" })
-- Select just pasted text in last used visual mode
-- nnoremap <expr> <Leader>v '`[' . visualmode() . '`]'

-- LSP mappings
Util.lsp.on_attach(function(client, bufnr)
	local flags = { buffer = bufnr, silent = true, noremap = true }
	local nnoremap = function(lhs, rhs, ...)
		vim.keymap.set("n", lhs, rhs, vim.tbl_extend("keep", vim.empty_dict(), ... or vim.empty_dict(), flags))
	end
	local inoremap = function(lhs, rhs, ...)
		vim.keymap.set("i", lhs, rhs, vim.tbl_extend("keep", vim.empty_dict(), ... or vim.empty_dict(), flags))
	end
	if client.server_capabilities.definitionProvider then
		nnoremap("<C-]>", vim.lsp.buf.definition, { desc = "Go to definition" })
	end
	if client.server_capabilities.definitionProvider then
		nnoremap("gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" })
	end

	if client.server_capabilities.hoverProvider then
		nnoremap("K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show documentation" })
	end
	if client.server_capabilities.referencesProvider then
		nnoremap("gh", "<cmd>Lspsaga finder def+ref<CR>", { desc = "Find code references" })
	end
	-- Using LazyVim default <leader>ca
	-- if client.server_capabilities.codeActionProvider then
	-- 	nnoremap("<leader>a", "<cmd>Lspsaga code_action<CR>", { desc = "Trigger code action" })
	-- end
	if client.server_capabilities.renameProvider then
		nnoremap("gr", "<cmd>Lspsaga rename<CR>", { desc = "Rename symbol (LSP)" })
	end

	nnoremap("<space>d", "<cmd>Lspsaga show_line_diagnostics<CR>")
	-- nnoremap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	-- nnoremap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

	-- Set some keybinds conditional on server capabilities
	-- if client.server_capabilities.documentFormattingProvider then
	--   nnoremap("<space>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
	--   vim.api.nvim_create_autocmd("BufWritePre", {
	--     group = vim.api.nvim_create_augroup("cehoffman_lsp_format", { clear = true }),
	--     buffer = bufnr,
	--     callback = function()
	--       vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
	--     end,
	--   })
	--   -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false, timeout_ms = 1000})]]
	-- elseif client.server_capabilities.documentRangeFormattingProvider then
	--   nnoremap("<space>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
	--   vim.api.nvim_create_autocmd("BufWritePre", {
	--     group = vim.api.nvim_create_augroup("cehoffman_lsp_format", { clear = true }),
	--     buffer = bufnr,
	--     callback = function()
	--       vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
	--     end,
	--   })
	--   -- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false, timeout_ms = 1000})]])
	-- end
end)
