local M = {}

function M.setup()
  vim.keymap.nmap {"<C-o>", "o", buffer = true}
  vim.keymap.nmap {"<C-i>", "O", buffer = true}
end

function M.init()
  require("cehoffman.util").au(
    "gitmessenger_customize",
    "FileType gitmessengerpopup :lua require('cehoffman.gitmessenger').setup()"
  )
end

return M
