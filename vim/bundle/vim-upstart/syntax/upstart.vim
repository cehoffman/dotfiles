" Vim syntax file
" Language:	Upstart job files
" Maintainer:	Michael Biebl <biebl@debian.org>
" Last Change:	2007 Feb 13
" License:	GPL v2
" Version:	0.1
" Remark:	Syntax highlighting for upstart job files.
"
" It is inspired by the initng syntax file and includes sh.vim to do the
" highlighting of script blocks.

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

let is_bash = 1
"unlet! b:current_syntax
syn include @Shell syntax/sh.vim

syn case match

syn match upstartComment /#.*$/ contains=upstartTodo
syn keyword upstartTodo TODO FIXME contained

syn region upstartString start=/"/ end=/"/ skip=/\\"/

syn region upstartScript matchgroup=upstartStatement start="script" end="end script" contains=@upstartShellCluster

syn cluster upstartShellCluster contains=@Shell

" one argument
syn keyword upstartStatement description author version
syn keyword upstartStatement pid kill normal console env umask nice limit chroot chdir exec

" one or more arguments (events)
syn keyword upstartStatement emits

syn keyword upstartStatement on start stop

" flag, no parameter
syn keyword upstartStatement daemon respawn service instance

" prefix for exec or script
syn keyword upstartOption pre-start post-start pre-stop post-stop

" options for pid
syn keyword upstartOption file binary timeout
" option for
syn keyword upstartOption timeout
" option for respawn
syn keyword upstartOption limit
" options for console
syn keyword upstartOption logged output owner none

syn keyword upstartEvent startup stalled control-alt-delete kbdrequest starting started stopping stopped runlevel

hi def link upstartComment Comment
hi def link upstartTodo	Todo
hi def link upstartString String
hi def link upstartStatement Statement
hi def link upstartOption Type
hi def link upstartEvent Define

let b:current_syntax = "upstart"
