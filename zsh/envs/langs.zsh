typeset -gA ENV_LANGS
ENV_LANGS=(ruby red python yellow nodejs green elixir magenta)
function {
  local lang
  local funs
  local shlist
  if [[ -d "$HOME/.asdf" ]]; then
    export ASDF_DIR="$HOME/.asdf"
    export ASDF_BIN="${ASDF_DIR}/bin"
    export ASDF_USER_SHIMS="${ASDF_DIR}/shims"
    export ASDF_CONFIG_FILE="${HOME}/.dotfiles/asdfrc"
    path[2,1]=("${ASDF_BIN}" "${ASDF_USER_SHIMS}")
    source "${ASDF_DIR}/lib/asdf.sh"
    if [[ -o interactive ]]; then
      fpath+=(~/.asdf/completions)

      for lang in ${(k)ENV_LANGS}; do
        funs="
        function __${lang}_manpath() {
          local cur=\$(asdf current ${lang} | awk '{print \$2}')
          if [[ "\$cur" != "\$__cur_${lang}_version" ]]; then
            local mpath
            for mpath in \$manpath; do
              if [[ \"\${mpath##$ASDF_DIR/installs/${lang}}\" != \"\${mpath}\" ]]; then
                manpath=(\"\${(@)manpath:#\$mpath}\")
              fi
            done
            manpath[1,0]=(\"$HOME/.asdf/installs/${lang}/\$cur/\"**\"/man\"(/))
          fi
          __cur_${lang}_version=\$cur
        }"
        eval "$funs"
        chpwd_functions+=(__${lang}_manpath)
        __${lang}_manpath
      done
    fi
  fi
}
