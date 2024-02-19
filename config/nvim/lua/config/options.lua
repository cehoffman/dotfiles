vim.env.DYLD_INSERT_LIBRARIES = nil
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.title = true
vim.opt.writeany = true
vim.opt.scrolljump = 3
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 7
vim.opt.sidescroll = 1

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.formatoptions:append("1p/")

vim.opt.colorcolumn = "+1"
vim.opt.linebreak = true
vim.opt.cpoptions:append("n")
vim.opt.showbreak = " …"
vim.opt.cinoptions = ":0,l1,g0,t0,(0,Ws"
-- vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", eol = "¬", precedes = "<", extends = ">", nbsp = "·" }
vim.opt.conceallevel = 1
vim.opt.maxmempattern = 10000

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/site/undo"
vim.opt.backupdir = vim.fn.stdpath("data") .. "/site/backup"
vim.opt.backupcopy = "yes"
vim.opt.swapfile = false
vim.opt.spellfile = vim.fn.expand("~") .. "/.dotfiles/vim/spell/common.utf-8.add"

vim.opt.wildignore:append("*.o,*.rbc,*.obj,*.pyc,.git,CVS,.svn,tags,.hg")
vim.opt.wildignorecase = true
vim.opt.complete:append("i,kspell")
-- Completion options are overriden by nvim-cmp and should be set there instead
vim.opt.completeopt:append("noinsert")

-- This doesn't seem to work
-- vim.opt.pastetoggle = "<F2>"

-- Folding summary at the textwidth column marker
function _G.SimpleFold()
	local line = vim.fn.getline(vim.v.foldstart)

	-- Compute how many column the left cutter takes
	local numcolwidth = 0
	if vim.wo.number or vim.wo.relativenumber then
		numcolwidth = vim.wo.numberwidth
	end
	if vim.wo.signcolumn == "yes" then
		numcolwidth = numcolwidth + 1
	end
	local windowwidth = vim.fn.winwidth(0) - numcolwidth - 3
	if vim.opt.textwidth:get() ~= 0 and vim.fn.winwidth(0) > vim.opt.textwidth:get() then
		windowwidth = vim.opt.textwidth:get()
	end
	local foldedlinecount = string.format("%d", tonumber(vim.v.foldend) - tonumber(vim.v.foldstart))

	-- Calculate how many spaces a tab is and replace tabs with spaces
	local onetab = vim.fn.strpart("          ", 0, vim.opt.tabstop:get())
	line = vim.fn.substitute(line, "\t", onetab, "g")

	line = vim.fn.strpart(line, 0, windowwidth - 1 - vim.fn.len(foldedlinecount))
	local fillcharcount = windowwidth - vim.fn.len(line) - vim.fn.len(foldedlinecount)
	return line .. string.rep(" ", fillcharcount) .. foldedlinecount .. "…"
end

vim.opt.foldtext = "v:lua.SimpleFold()"
-- Default is to use indent level and with the indent markers it appers to
-- allow more control in preliminary usage
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
