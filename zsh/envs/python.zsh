if (( $+commands[pip] )); then
  # pip zsh completion start
  if [[ -o interactive ]]; then
    function _pip_completion {
      local words cword
      read -Ac words
      read -cn cword
      reply=( $( COMP_WORDS="$words[*]" \
                COMP_CWORD=$(( cword-1 )) \
                PIP_AUTO_COMPLETE=1 $words[1] ) )
    }
    compctl -K _pip_completion pip
  fi
  # pip zsh completion end

  if (( $+commands[asdf] )); then
    pip() {
      command pip "$@"
      asdf reshim
    }
  fi
fi
