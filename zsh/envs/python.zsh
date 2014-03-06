if command -v virtualenv &> /dev/null; then
  # PIP config
  # export PIP_VIRTUALENV_BASE=$WORKON_HOME
  # export PIP_RESPECT_VIRTUALENV=true
  # export PIP_REQUIRE_VIRTUALENV=true
  export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"

  # function syspip() { PIP_REQUIRE_VIRTUALENV="" pip "$@" }
fi
