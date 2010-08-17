" OpenDefect() {{{1
" Open up the Jira defect
function! OpenDefect()
  !open "http://localhost:8080/browse/<cword>"
endfunction
" }}}1
" mappings {{{1
map <buffer> <localleader>co :call OpenDefect()<cr>
" }}}1
