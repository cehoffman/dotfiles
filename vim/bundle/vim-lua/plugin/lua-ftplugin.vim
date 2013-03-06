" Vim file type plug-in
" Language: Lua 5.1
" Author: Peter Odding <peter@peterodding.com>
" Last Change: August 27, 2011
" URL: http://peterodding.com/code/vim/lua-ftplugin

" Support for automatic update using the GLVS plug-in.
" GetLatestVimScripts: 3625 1 :AutoInstall: lua.zip

" Don't source the plug-in when it's already been loaded or &compatible is set.
if &cp || exists('g:loaded_lua_ftplugin')
  finish
endif

" Make sure the plug-in is only loaded once.
let g:loaded_lua_ftplugin = 1

" vim: ts=2 sw=2 et
