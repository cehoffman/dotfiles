if [[ -d $HOME/.npm/bin ]]; then
  path=($HOME/.npm/bin $path)
  NODE_PATH="$HOME/.npm/lib/node_modules"
  # $(npm root -g 2> /dev/null)
fi
