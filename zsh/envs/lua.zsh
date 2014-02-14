if [[ -x ~/.luaenv/bin/luaenv ]]; then
  path=(~/.luaenv/bin ~/.luaenv/shims $path)
  eval "$(luaenv init -)"
fi
