" Vim auto-load script
" Author: Peter Odding <peter@peterodding.com>
" Last Change: November 25, 2011
" URL: http://peterodding.com/code/vim/lua-ftplugin

let g:xolox#lua#version = '0.7'

function! xolox#lua#jumpblock(forward)
  let start = '\<\%(for\|function\|if\|repeat\|while\)\>'
  let middle = '\<\%(elseif\|else\)\>'
  let end = '\<\%(end\|until\)\>'
  let flags = a:forward ? '' : 'b'
  return searchpair(start, middle, end, flags, '!xolox#lua#tokeniscode()')
endfunction

function! s:getfunscope()
  let firstpos = [0, 1, 1, 0]
  let lastpos = getpos('$')
  while search('\<function\>', 'bW')
    if xolox#lua#tokeniscode()
      let firstpos = getpos('.')
      break
    endif
  endwhile
  if xolox#lua#jumpblock(1)
    let lastpos = getpos('.')
  endif
  return [firstpos, lastpos]
endfunction

function! xolox#lua#jumpthisfunc(forward)
  let cpos = [line('.'), col('.')]
  let fpos = [1, 1]
  let lpos = [line('$'), 1]
  while search('\<function\>', a:forward ? 'W' : 'bW')
    if xolox#lua#tokeniscode()
      break
    endif
  endwhile
  let cursorline = line('.')
  let [firstpos, lastpos] = s:getfunscope()
  if cursorline == (a:forward ? lastpos : firstpos)[1]
    " make the mapping repeatable (line wise at least)
    execute a:forward ? (lastpos[1] + 1) : (firstpos[1] - 1)
    let [firstpos, lastpos] = s:getfunscope()
  endif
  call setpos('.', a:forward ? lastpos : firstpos)
endfunction

function! xolox#lua#jumpotherfunc(forward)
  let view = winsaveview()
  " jump to the start/end of the function
  call xolox#lua#jumpthisfunc(a:forward)
  " search for the previous/next function
  while search('\<function\>', a:forward ? 'W' : 'bW')
    " ignore strings and comments containing 'function'
    if xolox#lua#tokeniscode()
      return 1
    endif
  endwhile
  call winrestview(view)
endfunction

function! xolox#lua#tokeniscode()
  return s:getsynid(0) !~? 'string\|comment'
endfunction

function! s:getsynid(transparent)
  let id = synID(line('.'), col('.'), 1)
  if a:transparent
    let id = synIDtrans(id)
  endif
  return synIDattr(id, 'name')
endfunction

if exists('loaded_matchit')

  function! xolox#lua#matchit()
    let cword = expand('<cword>')
    if cword == 'end'
      let s = ['function', 'if', 'for', 'while']
      let e = ['end']
      unlet! b:match_skip
    elseif cword =~ '^\(function\|return\|yield\)$'
      let s = ['function']
      let m = ['return', 'yield']
      let e = ['end']
      let b:match_skip = "xolox#lua#matchit_ignore('^luaCond$')"
      let b:match_skip .= " || (expand('<cword>') == 'end' && xolox#lua#matchit_ignore('^luaStatement$'))"
    elseif cword =~ '^\(for\|in\|while\|do\|repeat\|until\|break\)$'
      let s = ['for', 'repeat', 'while']
      let m = ['break']
      let e = ['end', 'until']
      let b:match_skip = "xolox#lua#matchit_ignore('^\\(luaCond\\|luaFunction\\)$')"
    elseif cword =~ '\(if\|then\|elseif\|else\)$'
      let s = ['if']
      let m = ['elseif', 'else']
      let e = ['end']
      let b:match_skip = "xolox#lua#matchit_ignore('^\\(luaFunction\\|luaStatement\\)$')"
    else
      let s = ['for', 'function', 'if', 'repeat', 'while']
      let m = ['break', 'elseif', 'else', 'return']
      let e = ['eend', 'until']
      unlet! b:match_skip
    endif
    let p = '\<\(' . join(s, '\|') . '\)\>'
    if exists('m')
      let p .=  ':\<\(' . join(m, '\|') . '\)\>'
    endif
    return p . ':\<\(' . join(e, '\|') . '\)\>'
  endfunction

  function! xolox#lua#matchit_ignore(ignored)
    let word = expand('<cword>')
    let type = s:getsynid(0)
    return type =~? a:ignored || type =~? 'string\|comment'
  endfunction

endif
