# Setup Rbenv if it exists
if [[ -x ~/.rbenv/bin/rbenv ]]; then
  path=(~/.rbenv/bin $path)
  eval "$(~/.rbenv/bin/rbenv init -)"
  function gem() {
    command gem "$@"
    case "$1" in
      "install" | "uninstall" | "upgrade" | "cleanup")
        rbenv rehash
        ;;
    esac
  }
fi

# Load up any special local lib dirs if needed
function {
  if [[ -z $LPK_PREFIX ]]; then
    typeset -gUT RUBYLIB ruby_lib

    # Add homebrew ruby compiles to path if they exist
    local ruby_libs
    local ruby_path

    ruby_libs=${(z)$(ruby -e "require 'rbconfig' unless defined?(RbConfig); puts RbConfig::CONFIG['ruby_version'], RbConfig::CONFIG['sitearch']")}

    for ruby_path in $LPKG_PREFIX/lib/ruby{,/site_ruby,/vendor_ruby}; do
      ruby_lib=($ruby_path(/) $ruby_path/$ruby_libs[1](/) $ruby_path/$ruby_libs[1]/$ruby_libs[2](/) $ruby_lib)
    done

    export RUBYLIB
  fi
}
