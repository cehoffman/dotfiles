local cUtils = require("cehoffman.util")

-- Wrap code files
vim.api.nvim_create_autocmd("FileType", {
  group = cUtils.augroup("wrap"),
  pattern = { "go", "lua", "jsx", "javascript", "ruby", "python" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.textwidth = 79
  end,
})

-- Cause man pages to format to 80 column width
vim.g.man_hardwrap = 1
vim.env.MANWIDTH = "80"

-- Help window is placed to right and includes link navigation keymaps
local function setupHelpManWindow(event)
  vim.cmd.wincmd("L")
  vim.api.nvim_win_set_width(0, 80)
  vim.opt_local.readonly = true
  vim.opt_local.spell = false
  vim.opt_local.winfixwidth = true
  vim.opt_local.signcolumn = "no"
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.list = false
  vim.opt_local.spell = false
  vim.opt_local.colorcolumn = ""
  vim.opt_local.foldcolumn = "0"
  vim.keymap.set("n", "<Space>", "<C-]>", { buffer = event.buf, remap = false, desc = "Follow link under cursor" })
  vim.keymap.set("n", "<CR>", "<C-]>", { buffer = event.buf, remap = false, desc = "Follow link under cursor" })
  vim.keymap.set("n", "<BS>", "<C-T>", { buffer = event.buf, remap = false, desc = "Return to previous document" })
end

vim.api.nvim_create_autocmd("FileType", {
  group = cUtils.augroup("help"),
  pattern = { "help", "man" },
  callback = function(event)
    -- Setup callback for when buffer is reused after window closed
    vim.api.nvim_create_autocmd("BufWinEnter", {
      buffer = event.buf,
      callback = setupHelpManWindow,
    })
  end,
})

-- Show absolute numbers in insert mode and unfocused windows
vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave", "FocusGained", "FocusLost", "InsertEnter", "InsertLeave" }, {
  group = cUtils.augroup("number"),
  pattern = { "*" },
  callback = function(event)
    if event.event == "BufEnter" or event.event == "FocusGained" or event.event == "InsertLeave" then
      if vim.api.nvim_get_option_value("number", { scope = "local" }) then
        vim.opt_local.relativenumber = true
        vim.opt_local.number = false
      end
    else
      if vim.api.nvim_get_option_value("relativenumber", { scope = "local" }) then
        vim.opt_local.relativenumber = false
        vim.opt_local.number = true
      end
    end
  end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.py", "*.rb", "*.md" },
  group = cUtils.augroup("whitespace"),
  callback = function()
    cUtils.trim_whitespace()
  end,
})

-- Reequalize windows on resize
vim.api.nvim_create_autocmd("VimResized", {
  group = cUtils.augroup("resize"),
  callback = function()
    vim.cmd([[
      wincmd =
    ]])
  end,
})

-- Mark .envrc as bash filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".envrc" },
  group = cUtils.augroup("envrc"),
  callback = function()
    vim.opt_local.filetype = "bash"
  end,
})

-- Give hotkeys more time outside of insert mode
local auInsert = cUtils.augroup("insert")
vim.api.nvim_create_autocmd("InsertEnter", {
  group = auInsert,
  callback = function()
    vim.opt.timeoutlen = 300
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = auInsert,
  callback = function()
    vim.opt.timeoutlen = 700
  end,
})

-- Only show cursorline in active window
vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave", "InsertEnter", "InsertLeave" }, {
  pattern = { "*" },
  group = cUtils.augroup("cursorline"),
  callback = function(event)
    if event.event == "WinEnter" or event.event == "InsertLeave" then
      vim.opt_local.cursorline = true
    else
      vim.opt_local.cursorline = false
    end
  end,
})

-- gitrebase helpers
vim.api.nvim_create_autocmd("FileType", {
  group = cUtils.augroup("gitrebase"),
  pattern = { "gitrebase" },
  callback = function(event)
    vim.keymap.set("n", "p", ":Pick<cr>", { buffer = event.buf, remap = false, desc = "Pick commit" })
    vim.keymap.set("n", "s", ":Squash<cr>", { buffer = event.buf, remap = false, desc = "Squash commit" })
    vim.keymap.set("n", "e", ":Edit<cr>", { buffer = event.buf, remap = false, desc = "Edit commit" })
    vim.keymap.set("n", "r", ":Reword<cr>", { buffer = event.buf, remap = false, desc = "Reword commit" })
    vim.keymap.set("n", "f", ":Fixup<cr>", { buffer = event.buf, remap = false, desc = "Fixup commit" })
    -- vim.keymap.set("n", "<C-j>", ":m +1<cr>", { buffer = event.buf, remap = false, desc = "Move commit down" })
    -- vim.keymap.set("n", "<C-k>", ":m -2<cr>", { buffer = event.buf, remap = false, desc = "Move commit up" })
  end,
})
