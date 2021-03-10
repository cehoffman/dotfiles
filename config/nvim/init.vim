set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists('g:started_by_firenvim')
  set guifont=Meslo\ LG\ M:h18
  set laststatus=0
endif
