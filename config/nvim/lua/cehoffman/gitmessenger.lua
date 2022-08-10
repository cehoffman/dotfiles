local M = {}

function M.setup()
  vim.keymap.set("n", "<C-o>", "o", {buffer = true})
  vim.keymap.set("n", "<C-i>", "O", {buffer = true})
end

function M.init()
  require("cehoffman.util").au(
    "gitmessenger_customize",
    "FileType gitmessengerpopup :lua require('cehoffman.gitmessenger').setup()"
  )
  vim.g.git_messenger_floating_win_opts = {border = "double"}
end

return M
