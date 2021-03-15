vim.keymap.nnoremap {"<C-W>o", ":Goyo<CR>", silent = true}
vim.g.goyo_width = "90%"
require("cehoffman.util").au(
  "goyo_custom", "User GoyoEnter Limelight", "User GoyoLeave Limelight!"
)
