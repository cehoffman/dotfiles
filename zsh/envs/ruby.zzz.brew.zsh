if [[ -a ~/.homebrew/bin/brew ]]; then
  function {
    export LPKG_PREFIX="$HOME/.homebrew"
    echo $path
    path=($LPKG_PREFIX/bin $path)
    echo $path
    path=($(brew --prefix coreutils)/libexec/gnubin(/) $LPKG_PREFIX/sbin(/) $path)
    echo $path
    manpath=($(brew --prefix coreutils)/libexec/gnuman(/) $LPKG_PREFIX/share/man(/) $manpath)
    fpath=($LPKG_PREFIX/share/zsh/functions(/) $fpath)

    # Homebrew Python setup
    path=($(python -c "from sys import prefix; print prefix")/bin $path)
    path=($LPKG_PREFIX/share/python $path)

    if [[ $IS_LINUX -eq 1 ]]; then
      export LD_LIBRARY_PATH="$LPKG_PREFIX/lib:$LD_LIBRARY_PATH"
    fi
  }
else
  unset LPKG_PREFIX
fi
