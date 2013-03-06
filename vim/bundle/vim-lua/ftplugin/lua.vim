" Vim file type plug-in
" Language: Lua 5.1
" Author: Peter Odding <peter@peterodding.com>
" Last Change: June 18, 2011
" URL: http://peterodding.com/code/vim/lua-ftplugin

if exists('b:did_ftplugin')
  finish
else
  let b:did_ftplugin = 1
endif

" A list of commands that undo buffer local changes made below.
let s:undo_ftplugin = []

" Set comment (formatting) related options. {{{1
setlocal fo-=t fo+=c fo+=r fo-=o fo+=q fo+=l
setlocal cms=--\ %s com=s:--[[,m:\ ,e:]],:--
call add(s:undo_ftplugin, 'setlocal fo< cms< com<')

" Enable completion of Lua keywords, globals and library members. {{{1
setlocal completefunc=xolox#lua#completefunc
call add(s:undo_ftplugin, 'setlocal completefunc<')

" Enable dynamic completion by searching "package.path" and "package.cpath". {{{1
setlocal omnifunc=xolox#lua#omnifunc
call add(s:undo_ftplugin, 'setlocal omnifunc<')

" Define custom text objects to navigate Lua source code. {{{1
noremap <buffer> <silent> [{ m':call xolox#lua#jumpblock(0)<Cr>
noremap <buffer> <silent> ]} m':call xolox#lua#jumpblock(1)<Cr>
noremap <buffer> <silent> [[ m':call xolox#lua#jumpthisfunc(0)<Cr>
noremap <buffer> <silent> ][ m':call xolox#lua#jumpthisfunc(1)<Cr>
noremap <buffer> <silent> [] m':call xolox#lua#jumpotherfunc(0)<Cr>
noremap <buffer> <silent> ]] m':call xolox#lua#jumpotherfunc(1)<Cr>
call add(s:undo_ftplugin, 'unmap <buffer> [{')
call add(s:undo_ftplugin, 'unmap <buffer> ]}')
call add(s:undo_ftplugin, 'unmap <buffer> [[')
call add(s:undo_ftplugin, 'unmap <buffer> ][')
call add(s:undo_ftplugin, 'unmap <buffer> []')
call add(s:undo_ftplugin, 'unmap <buffer> ]]')

" Enable extended matching with "%" using the "matchit" plug-in. {{{1
if exists('loaded_matchit')
  let b:match_ignorecase = 0
  let b:match_words = 'xolox#lua#matchit()'
  call add(s:undo_ftplugin, 'unlet! b:match_ignorecase b:match_words b:match_skip')
endif

" Enable tool tips with function signatures? {{{1
if has('balloon_eval')
  setlocal ballooneval balloonexpr=xolox#lua#getsignature(v:beval_text)
  call add(s:undo_ftplugin, 'setlocal ballooneval< balloonexpr<')
endif

" }}}1

" Let Vim know how to disable the plug-in.
call map(s:undo_ftplugin, "'execute ' . string(v:val)")
let b:undo_ftplugin = join(s:undo_ftplugin, ' | ')
unlet s:undo_ftplugin

" vim: ts=2 sw=2 et
