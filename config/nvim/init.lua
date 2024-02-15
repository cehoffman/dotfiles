local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo

require("cehoffman.first_load")
-- require("cehoffman.plugins")

local util = require("cehoffman.util")
util.au(
  "patch_terminal", "TermOpen * setlocal norelativenumber | startinsert",
  "TermClose * stopinsert"
)

-- vim.cmd [[
--   source ~/.vimrc
-- ]]

if vim.g.started_by_firenvim then
  vim.o.guifont = "Meslo LG M:h18"
  vim.o.laststatus = 0
end
