if [[ -a ~/.homebrew/bin/brew ]]; then
  function {
    local coreutils="$HOME/.homebrew/opt/coreutils" # $(brew --prefix coreutils)
    path=($HOME/.homebrew/bin $path)
    path=($coreutils/libexec/gnubin(/) $HOME/.homebrew/sbin(/) $path)
    manpath=($coreutils/libexec/gnuman(/) $HOME/.homebrew/share/man(/) $manpath)
    fpath=($HOME/.homebrew/share/zsh/functions(/) $fpath)

    # Homebrew Python setup
    # if [[ -d $HOME/.homebrew/Cellar/python ]]; then
    #   path=($(python -c "from sys import prefix; print prefix")/bin $path)
    #   path=($HOME/.homebrew/share/python $path)
    # fi

    if [[ $IS_LINUX = 0 ]]; then
      export LD_LIBRARY_PATH="$HOME/.homebrew/lib:$LD_LIBRARY_PATH"
    fi
  }
fi
