typeset -gA ENV_LANGS
ENV_LANGS=(rb red lua cyan py yellow)
function {
  local lang
  local funs
  for lang in ${(k)ENV_LANGS}; do
    if [[ -x "$HOME/.${lang}env/bin/${lang}env" ]]; then
      path=("$HOME/.${lang}env/bin" "$HOME/.${lang}env/shims" $path)
      source "$HOME/.${lang}env/completions/${lang}env.zsh"
      if [[ -o interactive ]]; then
        funs="
        function ${lang}env() {
          local cmd=\"\$1\"
          if [ \"\$#\" -gt 0 ]; then
            shift
          fi
          case \"\$cmd\" in
            rehash|shell)
              eval \"\$(${lang}env sh-\$cmd \"\$@\")\"
            ;;
            *)
              command ${lang}env \"\$cmd\" \"\$@\"
            ;;
          esac
        }
        function __${lang}env_manpath() {
          local mpath
          for mpath (~/.${lang}env/versions/*(/)) manpath=(\"\${(@)manpath:#\$mpath/share/man}\")
          manpath[1,0]=(\"$HOME/.${lang}env/versions/\$(${lang}env version-name)/share/man\"(/))
        }"
        eval "$funs"
        precmd_functions+=(__${lang}env_manpath)
      fi
    fi
  done
}
