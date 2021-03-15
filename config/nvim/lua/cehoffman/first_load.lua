local download_packer = function()
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath("data"))

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format(
      "git clone %s %s", "https://github.com/wbthomason/packer.nvim",
      directory .. "/packer.nvim"
    )
  )

  print(out)
  print("Downloading packer.nvim...")
  vim.api.nvim_command "packadd packer.nvim"
end

if not pcall(require, "packer") then
  download_packer()
end
