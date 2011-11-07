if [[ -d ~/.rbenv ]]; then
  path=(~/.rbenv/shims ~/.rbenv/bin $path)
  source ~/.rbenv/completions/rbenv.zsh
  function gem() {
    command gem "$@"
    case "$1" in
      "install" | "uninstall" | "upgrade" | "cleanup")
        rbenv rehash
        ;;
    esac
  }
fi
