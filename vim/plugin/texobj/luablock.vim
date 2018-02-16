if exists('g:loaded_textobj_luablock')  "{{{1
  finish
endif

" Interface  "{{{1
if exists('*textobj#user#plugin')
  call textobj#user#plugin('luablock', {
  \      '-': {
  \        '*sfile*': expand('<sfile>:p'),
  \        'select-a': 'al',  '*select-a-function*': 's:select_a',
  \        'select-i': 'il',  '*select-i-function*': 's:select_i'
  \      }
  \    })
endif

" Misc.  "{{{1
let s:start_pattern = '\v(<function>|<if>|<for>|<do>|<repeat>|<while>)'
let s:end_pattern = '\v(<end>|<until>)'
let s:skip_pattern = 'getline(".") =~ "^\\s*--""'

function! s:select_a()
  let s:flags = 'cW'
  if expand('<cword>') =~ s:end_pattern
    let s:flags = 'cbW'
  endif

  call searchpair(s:start_pattern,'',s:end_pattern, s:flags, s:skip_pattern)
  let end_pos = getpos('.')

  " Jump to match
  normal %
  let start_pos = getpos('.')

  return ['V', start_pos, end_pos]
endfunction

function! s:select_i()
  let sel = s:select_a()

  " Adjust start and end to be inside block unless block is only one line
  if sel[1][1] != sel[2][1]
    let sel[2][1] = sel[2][1] - 1
    let sel[1][1] = sel[1][1] + 1
  endif

  return sel
endfunction

" Fin.  "{{{1

let g:loaded_textobj_luablock = 1

" __END__
" vim: foldmethod=marker
