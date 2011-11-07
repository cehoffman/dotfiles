if [[ -d ~/.rbenv ]]; then
  eval "$(~/.rbenv/bin/rbenv init -)"
  # path=(~/.rbenv/shims ~/.rbenv/bin $path)
  function gem() {
    command gem "$@"
    case "$1" in
      "install" | "uninstall" | "upgrade" | "cleanup")
        rbenv rehash
        ;;
    esac
  }
fi
