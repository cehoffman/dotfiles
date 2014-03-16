if [[ -d ~/.homebrew ]]; then
  function {
    local coreutils=~/.homebrew/opt/coreutils
    path[1,0]=($coreutils:q/libexec/gnubin(/) ~/.homebrew/sbin(/) ~/.homebrew/bin)
    manpath[1,0]=($coreutils:q/libexec/gnuman(/) ~/.homebrew/share/man(/))
    fpath[1,0]=(~/.homebrew/share/zsh/functions(/))

    if [[ $IS_LINUX = 0 ]]; then
      typeset -xTgU LD_LIBRARY_PATH ld_library_path
      ld_library_path[1,0]=(~/.homebrew/lib(/))
    fi
  }
fi
