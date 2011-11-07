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
