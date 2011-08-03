if has("mac")
  " Make ⌘F enter fullscreen
  set fuopt+=maxhorz
  macmenu Edit.Find.Find\.\.\. key=<nop>
  map <D-f> :set invfu<CR>
  set fu
end
