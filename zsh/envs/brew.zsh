if [[ -a ~/.homebrew/bin/brew ]]; then
  function {
    local brew_prefix="$HOME/.homebrew"
    path=($brew_prefix/bin $path)
    path=($(brew --prefix coreutils)/libexec/gnubin $brew_prefix/sbin $path)
    manpath=($brew_prefix/share/man $manpath)
    fpath=($brew_prefix/share/zsh/functions $fpath)

    # Homebrew Python setup
    path=($(python -c "from sys import prefix; print prefix")/bin $path)
    path=($brew_prefix/share/python $path)

    # Add homebrew ruby compiles to path if they exist
    local ruby_libs
    ruby_libs=${(z)$(ruby -e "exec_prefix = RbConfig::CONFIG['exec_prefix']; puts ['sitelibdir', 'sitearchdir', 'sitedir', 'vendorlibdir', 'vendorarchdir', 'vendordir', 'rubylibdir', 'archdir'].map { |dir| RbConfig::CONFIG[dir].sub(exec_prefix, '$brew_prefix') }.select { |dir| File.directory?(dir) }.map { |dir| dir.gsub(' ', '\\\\ ') }.join(' ')")}
    if [[ ${#ruby_libs} > 0 ]]; then
      export RUBYOPT="${RUBYOPT} -I${(j: -I:)ruby_libs}"
    fi
  }
fi
