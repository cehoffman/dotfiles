local M = {}

function M.au(group, ...)
  vim.cmd("augroup " .. group)
  vim.cmd([[au!]])
  for _, c in ipairs({ ... }) do
    vim.cmd("au " .. c)
  end
  vim.cmd("augroup END")
end

function M.augroup(name)
  return vim.api.nvim_create_augroup("cehoffman_" .. name, { clear = true })
end

function M.trim_whitespace()
  vim.cmd([[
    %s/\s\+$//e
  ]])
end

return M
