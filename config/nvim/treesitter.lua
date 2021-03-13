require('nvim-treesitter.configs').setup {
  ensure_installed = {"go", "python", "java", "typescript"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
    enable = true,
    -- disable = {"go"},
  },
}

