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
vim.opt.completeopt:append("noinsert")

-- This doesn't seem to work
-- vim.opt.pastetoggle = "<F2>"

-- Folding at the textwidth
vim.cmd([[
  function! SimpleFold()
    let line = getline(v:foldstart)

    let numcolwidth = &foldcolumn + (&number + &relativenumber) * &numberwidth
    if &textwidth != 0 && winwidth(0) > &textwidth
      let windowwidth = &textwidth
    else
      let windowwidth = winwidth(0) - numcolwidth - 3
    endif
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 1 - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . repeat(" ", fillcharcount) . foldedlinecount . '…' . ' '
  endfunction
  set foldtext=SimpleFold()
]])
-- Default is to use indent level and with the indent markers it appers to
-- allow more control in preliminary usage
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
