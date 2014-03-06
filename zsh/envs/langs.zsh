typeset -gA ENV_LANGS
ENV_LANGS=(rb red lua cyan py yellow)
function {
  local lang
  for lang in ${(k)ENV_LANGS}; do
    if [[ -x "$HOME/.${lang}env/bin/${lang}env" ]]; then
      path=("$HOME/.${lang}env/bin" "$HOME/.${lang}env/shims" $path)
      source "$HOME/.${lang}env/completions/${lang}env.zsh"
    fi
  done
}
