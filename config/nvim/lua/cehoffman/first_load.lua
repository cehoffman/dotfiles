-- local download_packer = function()
--   if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
--     return
--   end
--   local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath("data"))
--   vim.fn.mkdir(directory, "p")
--   local out = vim.fn.system(
--     string.format(
--       "git clone %s %s", "https://github.com/wbthomason/packer.nvim",
--       directory .. "/packer.nvim"
--     )
--   )
--   print(out)
--   print("Downloading packer.nvim...")
--   vim.api.nvim_command "packadd packer.nvim"
-- end
-- if not pcall(require, "packer") then
--   download_packer()
-- end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    spec = { { "LazyVim/LazyVim", import = "lazyvim.plugins" }, { import = "plugins" } },
    -- spec = { import = "plugins" },
    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }
)
