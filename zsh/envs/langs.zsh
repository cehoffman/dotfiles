typeset -gA ENV_LANGS
# ENV_LANGS=(rb red lua cyan py yellow nod red)
ENV_LANGS=(ruby red luajit cyan python yellow nodejs green elixir magenta)
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
          local cur=\$(asdf current ${lang} | sed 's|\s*(.*||')
          if [[ "\$cur" != "\$__cur_${lang}_version" ]]; then
            local mpath
            for mpath (~/.asdf/installs/${lang}/**/*/man(/)) manpath=(\"\${(@)manpath:#\$mpath}\")
            manpath[1,0]=(\"$HOME/.asdf/installs/\$cur/**/*/man\"(/))
          fi
          __cur_${lang}_version=\$cur
        }"
        eval "$funs"
        chpwd_functions+=(__${lang}_manpath)
      done
    fi
  fi

  for lang in ${(k)ENV_LANGS}; do
    if [[ -x "$HOME/.${lang}env/bin/${lang}env" ]]; then
      path[1,0]=(~/.${lang}env/bin ~/.${lang}env/shims)
      export ${(U)lang}ENV_SHELL=zsh
      export ${(U)lang}ENV_ROOT="${HOME}/.${lang}env"
      source ~/.${lang}env/completions/${lang}env.zsh
      if [[ -o interactive ]]; then
        shlist=(~/.${lang}env/libexec/${lang}env-sh-*(:t) ~/.${lang}env/plugins/*/bin/${lang}env-sh-*(:t))
        funs="
        function ${lang}env() {
          local cmd=\"\$1\"
          if [ \"\$#\" -gt 0 ]; then
            shift
          fi
          case \"\$cmd\" in
            ${(j:|:)shlist//${lang}env-sh-})
              eval \"\$(${lang}env sh-\$cmd \"\$@\")\"
            ;;
            *)
              command ${lang}env \"\$cmd\" \"\$@\"
            ;;
          esac
        }
        function __${lang}env_manpath() {
          local cur=\$(${lang}env version-name)
          if [[ "\$cur" != "\$__cur_${lang}env_version" ]]; then
            local mpath
            for mpath (~/.${lang}env/versions/*(/)) manpath=(\"\${(@)manpath:#\$mpath/share/man}\")
            manpath[1,0]=(\"$HOME/.${lang}env/versions/\$cur/share/man\"(/))
          fi
          __cur_${lang}env_version=\$cur
        }"
        eval "$funs"
        chpwd_functions+=(__${lang}env_manpath)
      fi
    fi
  done
}
