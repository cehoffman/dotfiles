if [[ -d ~/.homebrew ]]; then
  # Disable analytics
  export HOMEBREW_NO_ANALYTICS=1

  function {
    local coreutils=~/.homebrew/opt/coreutils
    local gnutar=~/.homebrew/opt/gnu-tar
    local gnused=~/.homebrew/opt/gnu-sed
    local findutils=~/.homebrew/opt/findutils
    local make=~/.homebrew/opt/make
    path[1,0]=($make:q/libexec/gnubin(-/) $findutils:q/libexec/gnubin(-/) $gnused:q/libexec/gnubin(-/) $gnutar:q/libexec/gnubin(-/) $coreutils:q/libexec/gnubin(-/) ~/.homebrew/sbin(-/) ~/.homebrew/bin)
    manpath[1,0]=($make:q/libexec/gnuman(-/) $findutils:q/libexec/gnuman(-/) $gnused:q/libexec/gnuman(-/) $gnutar:q/libexec/gnuman(-/) $coreutils:q/libexec/gnuman(-/) ~/.homebrew/share/man(-/))

    # Reorder zsh function directories because homebrew inserts them in the
    # wrong precedence order
    local fps
    local fp
    fps=(~/.homebrew/share/zsh/functions(-/)
         ~/.homebrew/Cellar/zsh/$ZSH_VERSION/share/zsh/functions(-/)
         ~/.homebrew/share/zsh/site-functions(-/))
    for fp ($fps) fpath=("${(@)fpath:#$fp}")
    fpath+=($fps)

    if [[ $IS_LINUX = 0 ]]; then
      typeset -xTgU LD_LIBRARY_PATH ld_library_path
      ld_library_path[1,0]=(~/.homebrew/lib(-/))
    fi

  }

  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

  if [ -f ~/.homebrew/opt/dvm/dvm.sh ]; then
    source ~/.homebrew/opt/dvm/dvm.sh
    eval "original_$(declare -f dvm)"
    dvm() {
      DYLD_INSERT_LIBRARIES= original_dvm "$@"
    }
  fi

  # Stop homebrew from removing my ability to revert an update easily, dicks
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  alias brew="env -u http_proxy -u https_proxy -u GIT_SSL_CERT -u GIT_SSL_KEY -u GIT_SSL_CAINFO -u DYLD_INSERT_LIBRARIES brew"
fi
