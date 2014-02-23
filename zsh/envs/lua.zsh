if [[ -x ~/.luaenv/bin/luaenv ]]; then
  path=(~/.luaenv/bin ~/.luaenv/shims $path)
  source ~/.luaenv/completions/luaenv.zsh
  # eval "$(luaenv init -)"
fi
