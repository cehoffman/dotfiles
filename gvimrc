set t_Co=256
" Remove the toolbar
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions+=c

colorscheme plasticcodewrap
set guitablabel=%N\ %t%q\ %m[%{tabpagewinnr(tabpagenr())}]

if has("mac")
  " Make ⌘F enter fullscreen
  set guifont=MesloLGS:h11
  set fuopt+=maxhorz
  macmenu Edit.Find.Find\.\.\. key=<nop>
  map <D-f> :set invfu<CR>
  set linespace=0
  set fu
end

if has("gui_gnome")
  set term=gnome-256color
  set guifont=Inconsolata\ Medium\ 12
endif

if has("gui_win32") || has("gui_win32s")
  set guifont=Meslo_LG_S:h10
  set linespace=-2
endif
