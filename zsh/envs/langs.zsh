function {
  for lang in rb lua py; do
    if [[ -x "$HOME/.${lang}env/bin/${lang}env" ]]; then
      path=("$HOME/.${lang}env/bin" "$HOME/.${lang}env/shims" $path)
      source "$HOME/.${lang}env/completions/${lang}env.zsh"

      if [[ lang = "rb" ]]; then
        function gem() {
          command gem "$@"
          case "$1" in
            "install" | "uninstall" | "upgrade" | "cleanup")
              rbenv rehash
              ;;
          esac
        }
      fi
    fi
  done
}
