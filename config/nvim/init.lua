-- Force stable python host
if vim.fn.filereadable(vim.fn.expand("~") .. "/.venvs/neovim/bin/python3") then
	vim.g.python3_host_prog = vim.fn.expand("~") .. "/.venvs/neovim/bin/python3"
	vim.env.PATH = vim.fn.expand("~") .. "/.venvs/neovim/bin:" .. vim.env.PATH
end

require("cehoffman.first_load")

-- local util = require("cehoffman.util")
-- util.au("patch_terminal", "TermOpen * setlocal norelativenumber | startinsert", "TermClose * stopinsert")

-- if vim.g.started_by_firenvim then
-- 	vim.o.guifont = "Meslo LG M:h18"
-- 	vim.o.laststatus = 0
-- end
