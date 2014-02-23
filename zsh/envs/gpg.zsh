function start-gpg() {
  if [[ -o interactive ]]; then
    if command -v gpg-agent &> /dev/null; then
      eval $(gpg-agent --daemon --write-env-file --enable-ssh-support)
    fi
  fi
}

if [[ -f ~/.gpg-agent-info ]]; then
  source ~/.gpg-agent-info
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
  export GPG_TTY=$(tty)
else
  start-gpg
fi

if [[ -n "$GPG_AGENT_INFO" ]]; then
  if ps -p $(echo $GPG_AGENT_INFO | cut -d : -f 2) | grep gpg-agent &> /dev/null; then
    eval $(cut -d = -f 1 < ~/.gpg-agent-info | xargs echo export)
  else
    start-gpg
  fi
else
  start-gpg
fi

unfunction start-gpg

[[ -o interactive ]] && command -v gpg2 &> /dev/null && compdef gpg2=gpg
