# Setup Rbenv if it exists
if [[ -x ~/.rbenv/bin/rbenv ]]; then
  path=(~/.rbenv/bin $path)
fi

if command -v rbenv > /dev/null; then
  path=(~/.rbenv/shims ~/.rbenv/bin $path)
  eval "$(rbenv init - | grep completions)"
  function gem() {
    command gem "$@"
    case "$1" in
      "install" | "uninstall" | "upgrade" | "cleanup")
        rbenv rehash
        ;;
    esac
  }
fi

# Setup RVM otherwise
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm
elif [[ -s /usr/local/lib/rvm ]]; then
  source /usr/local/lib/rvm
fi

if command -v rvm > /dev/null; then
  function _run-with-bundler() {
    if command -v bundle > /dev/null 2>&1; then
      local check_path=$PWD
      while [ "$(dirname $check_path)" != '/' ]; do
        [ -f "$check_path/Gemfile" ] && break
        check_path="$(dirname $check_path)"
      done
      if [ -f "$check_path/Gemfile" ]; then
        bundle exec $@
      else
        $@
      fi
    else
      $@
    fi
  }

  for cmd in cap heroku rails rake spork; do
    alias $cmd="_run-with-bundler $cmd"
  done
fi

# Load up any special local lib dirs if needed
function {
  if [[ -z $LPK_PREFIX ]]; then
    # Add homebrew ruby compiles to path if they exist
    local ruby_libs
    local ruby_path
    local ruby_paths
    ruby_libs=${(z)$(ruby -e "require 'rbconfig' unless defined?(RbConfig); puts RbConfig::CONFIG['ruby_version'], RbConfig::CONFIG['sitearch']")}
    for ruby_path in $LPKG_PREFIX/lib/ruby{,/site_ruby,/vendor_ruby}; do
      ruby_paths=($ruby_path(/) $ruby_path/$ruby_libs[1](/) $ruby_path/$ruby_libs[1]/$ruby_libs[2](/))
      [[ $#ruby_paths > 0 ]] && RUBYOPT="${RUBYOPT} -I${(j: -I:)ruby_paths}"
    done
  fi
}
