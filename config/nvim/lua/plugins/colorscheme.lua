return {
  -- {
  --   "svrana/neosolarized.nvim",
  --   dependencies = { "tjdevries/colorbuddy.vim" },
  --   opts = { comment_italics = true, background_set = false },
  -- },
  { "folke/tokyonight.nvim", lazy = true,                        opts = { style = "moon" } },
  -- { "LazyVim/LazyVim", opts = { colorscheme = "neosolarized" } },
  { "LazyVim/LazyVim",       opts = { colorscheme = "tokyonight" } },
}
