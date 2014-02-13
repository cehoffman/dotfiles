if [[ -x ~/.dotfiles/luaenv/bin/luaenv ]]; then
  path=(~/.dotfiles/luaenv/bin ~/.luaenv/shims $path)
  eval "$(luaenv init -)"
fi
