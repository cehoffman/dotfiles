typeset -gA ENV_LANGS
ENV_LANGS=(ruby red python yellow nodejs green elixir magenta)
function {
  local lang
  local funs
  if [[ -d "$HOME/.asdf" ]]; then
    export ASDF_DIR="$HOME/.asdf"
    export ASDF_BIN="${ASDF_DIR}/bin"
    export ASDF_USER_SHIMS="${ASDF_DIR}/shims"
    export ASDF_CONFIG_FILE="${HOME}/.dotfiles/asdfrc"
    path[2,1]=("${ASDF_BIN}" "${ASDF_USER_SHIMS}")
    source "${ASDF_DIR}/asdf.sh"
    if [[ -o interactive ]]; then
      # Keep ASDF man files at front on manpath
      for mpath in $manpath; do
        if [[ "${mpath##${ASDF_DIR}/installs/}" != "${mpath}" ]]; then
          manpath[1,0]=($mpath:q)
        fi
      done

      fpath+=(~/.asdf/completions(/))

      for lang in ${(k)ENV_LANGS}; do
        funs="
        __init_asdf_${lang}() {
          if [[ -z "\$__cur_${lang}_version" ]]; then
            __${lang}_manpath
          fi
          precmd_functions[\${precmd_functions[(i)__init_asdf_${lang}]}]=()
          unfunction __init_asdf_${lang}
        }
        precmd_functions+=(__init_asdf_${lang})

        function __${lang}_manpath() {
          local cur=\$(asdf current ${lang} | awk '{print \$2}')
          if [[ "\$cur" != "\$__cur_${lang}_version" ]]; then
            local mpath
            for mpath in \$manpath; do
              if [[ \"\${mpath##${ASDF_DIR}/installs/${lang}}\" != \"\${mpath}\" ]]; then
                manpath=(\"\${(@)manpath:#\$mpath}\")
              fi
            done
            manpath[1,0]=(\"${ASDF_DIR}/installs/${lang}/\$cur/\"**\"/man\"(/))
          fi
          export __cur_${lang}_version=\$cur
        }"
        eval "$funs"
        chpwd_functions+=(__${lang}_manpath)
      done
    fi
  fi
}
