if [[ -a ~/.homebrew/bin/brew ]]; then
  function {
    export LPKG_PREFIX="$HOME/.homebrew"
    path=($LPKG_PREFIX/bin $path)
    path=($(brew --prefix coreutils)/libexec/gnubin(/) $LPKG_PREFIX/sbin(/) $path)
    manpath=($(brew --prefix coreutils)/libexec/gnuman(/) $LPKG_PREFIX/share/man(/) $manpath)
    fpath=($LPKG_PREFIX/share/zsh/functions(/) $fpath)

    # Homebrew Python setup
    if brew list | grep python &> /dev/null ; then
      path=($(python -c "from sys import prefix; print prefix")/bin $path)
      path=($LPKG_PREFIX/share/python $path)
    fi

    if [[ $IS_LINUX = 0 ]]; then
      export LD_LIBRARY_PATH="$HOME/.homebrew/lib:$LD_LIBRARY_PATH"
    fi
  }
else
  unset LPKG_PREFIX
fi
