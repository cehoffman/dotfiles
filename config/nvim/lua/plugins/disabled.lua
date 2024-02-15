return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/flash.nvim",        enabled = false },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader><tab>"] = nil
      opts.defaults["<leader>w"] = nil
      opts.defaults["<leader>n"] = { name = "+new" }
    end,
  },
}
