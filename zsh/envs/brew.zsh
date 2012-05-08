if [[ -a ~/.homebrew/bin/brew ]]; then
  function {
    export LPKG_PREFIX="$HOME/.homebrew"
    path=($LPKG_PREFIX/bin $path)
    path=($(brew --prefix coreutils)/libexec/gnubin $LPKG_PREFIX/sbin $path)
    manpath=($LPKG_PREFIX/share/man $manpath)
    fpath=($LPKG_PREFIX/share/zsh/functions $fpath)

    # Homebrew Python setup
    path=($(python -c "from sys import prefix; print prefix")/bin $path)
    path=($LPKG_PREFIX/share/python $path)

    # Add homebrew ruby compiles to path if they exist
    local ruby_libs
    ruby_libs=${(z)$(ruby -e "exec_prefix = RbConfig::CONFIG['exec_prefix']; puts ['sitelibdir', 'sitearchdir', 'sitedir', 'vendorlibdir', 'vendorarchdir', 'vendordir', 'rubylibdir', 'archdir'].map { |dir| RbConfig::CONFIG[dir].sub(exec_prefix, '$LPKG_PREFIX') }.select { |dir| File.directory?(dir) }.map { |dir| dir.gsub(' ', '\\\\ ') }.join(' ')")}
    if [[ ${#ruby_libs} > 0 ]]; then
      export RUBYOPT="${RUBYOPT} -I${(j: -I:)ruby_libs}"
    fi
  }
else
  unset LPKG_PREFIX
fi
