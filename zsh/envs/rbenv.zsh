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
