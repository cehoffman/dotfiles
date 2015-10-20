if [[ -d ~/.homebrew ]]; then
  function {
    local coreutils=~/.homebrew/opt/coreutils
    path[1,0]=($coreutils:q/libexec/gnubin(/) ~/.homebrew/sbin(/) ~/.homebrew/bin)
    manpath[1,0]=($coreutils:q/libexec/gnuman(/) ~/.homebrew/share/man(/))

    # Reorder zsh function directories because homebrew inserts them in the
    # wrong precedence order
    local fps
    local fp
    fps=(~/.homebrew/share/zsh/functions(/)
         ~/.homebrew/Cellar/zsh/$ZSH_VERSION/share/zsh/functions(/)
         ~/.homebrew/share/zsh/site-functions(/))
    for fp ($fps) fpath=("${(@)fpath:#$fp}")
    fpath+=($fps)

    if [[ $IS_LINUX = 0 ]]; then
      typeset -xTgU LD_LIBRARY_PATH ld_library_path
      ld_library_path[1,0]=(~/.homebrew/lib(/))
    fi

  }

  if (( $+commands[brew-cask.rb] )); then
    export HOMEBREW_CASK_OPTS="--binarydir=~/.homebrew/bin"
  fi

  alias brew="env -u GIT_SSL_CERT -u GIT_SSL_KEY -u GIT_SSL_CAINFO -u DYLD_INSERT_LIBRARIES brew"
fi
