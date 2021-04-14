local inoremap = vim.keymap.inoremap

require("compe").setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 100,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = false,
    nvim_lsp = true,
    nvim_lua = true,
    spell = false,
    tags = true,
    snippets_nvim = false,
    ultisnips = true,
    treesitter = false,
    omni = false,
    vim_dadbod_completion = true,
  },
}

inoremap {"<C-Space>", "compe#complete()", silent = true, expr = true}
inoremap {
  "<CR>",
  [[compe#confirm({'keys': "\<Plug>delimitMateCR\<Plug>DiscretionaryEnd", 'mode': ''})]],
  silent = true,
  expr = true,

}
inoremap {"<C-e>", "compe#confirm()", silent = true, expr = true}
inoremap {"<C-f>", "compe#scroll({ 'delta': +4 })", silent = true, expr = true}
inoremap {"<C-d>", "compe#scroll({ 'delta': -4 })", silent = true, expr = true}
inoremap {"<ESC>", "compe#close('<ESC>')", silent = true, expr = true}
