if [[ -x ~/.luaenv/bin/luaenv ]]; then
  path=(~/.luaenv/bin $path)
  eval "$(~/.luaenv/bin/luaenv init -)"
fi
