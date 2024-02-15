return {
  {
    "jamessan/vim-gnupg",
    config = function()
      vim.g.GPGExecutable = "gpg"
      vim.g.GPGDefaultRecipients = { "cehoffman@gmail.com" }
      vim.g.GPGUsePipes = 1
    end,
  },
}
