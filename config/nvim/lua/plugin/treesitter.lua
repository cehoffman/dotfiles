require("nvim-treesitter.configs").setup {
  ensure_installed = {"go", "python", "java", "typescript", "lua"},
  highlight = {enable = true},
  indent = {
    enable = true,
    -- disable = {"go"},
  },
}
