export DYLD_INSERT_LIBRARIES=$HOME/.homebrew/lib/libstderred.dylib

use_gpg() {
  if [ -f "${1}" ]; then
    eval "$(cat "${1}" | gpg -d)"
  fi
}
