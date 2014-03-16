if (( $+commands[virtualenv] )); then
  # PIP config
  export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
fi
