typeset -gA ENV_LANGS
ENV_LANGS=(ruby red  python yellow nodejs green elixir magenta)
function {
  local lang
  local funs
  local shlist
  if [[ -d "$HOME/.asdf" ]]; then
    path[1,0]=(~/.asdf/bin ~/.asdf/shims)
    if [[ -o interactive ]]; then
      __init_asdf_comp() {
        . ~/.asdf/completions/asdf.bash
        precmd_functions[${precmd_functions[(i)__init_asdf_comp]}]=()
        unfunction __init_asdf_comp
      }
      precmd_functions+=(__init_asdf_comp)

      for lang in ${(k)ENV_LANGS}; do
        funs="
        function __${lang}_manpath() {
          local cur=\$(asdf current ${lang} | awk '{print \$2}')
          if [[ "\$cur" != "\$__cur_${lang}_version" ]]; then
            local mpath
            for mpath (~/.asdf/installs/${lang}/**/*/man(/)) manpath=(\"\${(@)manpath:#\$mpath}\")
            manpath[1,0]=(\"$HOME/.asdf/installs/${lang}/\$cur/\"**\"/man\"(/))
          fi
          __cur_${lang}_version=\$cur
        }"
        eval "$funs"
        chpwd_functions+=(__${lang}_manpath)
      done
    fi
  fi
}
