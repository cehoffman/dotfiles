local M = {}

function M.au(group, ...)
  vim.cmd("augroup " .. group)
  vim.cmd [[au!]]
  for _, c in ipairs {...} do
    vim.cmd("au " .. c)
  end
  vim.cmd "augroup END"
end

return M
