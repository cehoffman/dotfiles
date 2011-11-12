if [[ -x ~/.rbenv/bin/rbenv ]]; then
  path=(~/.rbenv/bin $path)
fi

if command -v rbenv > /dev/null; then
  path=($(which rbenv)/../../shims $path)
  source $(which rbenv)/../../completions/rbenv.zsh
  function gem() {
    command gem "$@"
    case "$1" in
      "install" | "uninstall" | "upgrade" | "cleanup")
        rbenv rehash
        ;;
    esac
  }
fi
