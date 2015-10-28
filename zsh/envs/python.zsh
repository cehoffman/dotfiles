if (( $+commands[virtualenv] )); then
  # PIP config
  export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
fi

if (( $+commands[pip] )); then
  # pip zsh completion start
  function _pip_completion {
    local words cword
    read -Ac words
    read -cn cword
    reply=( $( COMP_WORDS="$words[*]" \
              COMP_CWORD=$(( cword-1 )) \
              PIP_AUTO_COMPLETE=1 $words[1] ) )
  }
  compctl -K _pip_completion pip
  # pip zsh completion end

  if (( $+commands[pyenv] )); then
    pip() {
      command pip $@
      pyenv rehash
    }
  fi
fi
