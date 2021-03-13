require('lspsaga').init_lsp_saga({
  error_sign = '✖',
  warn_sign = '‼',
  hint_sign = '➜',
  infor_sign = '⚑',
  dianostic_header_icon = ' ‼️  ',
  code_action_icon = '💡',
  finder_definition_icon = '❃ ',
  finder_reference_icon = '❃ ',
  definition_preview_icon = '❃ ',
  border_style = 2,
  code_action_keys = {
    quit = {'<esc>', 'q'},
  },
  finder_action_keys = {
    quit = {'<esc>', 'q'},
  },
  rename_action_keys = {
    quit = {'<esc>', '<C-c>'},
  },
})
