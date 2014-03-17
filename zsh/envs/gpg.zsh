function start-gpg() {
  if [[ -o interactive && $+commands[gpg-agent] -eq 1 ]]; then
    eval $(gpg-agent --daemon --write-env-file --enable-ssh-support)
  fi
}

if [[ -f ~/.gpg-agent-info ]]; then
  eval "export ${(fj:\nexport :)$(cat ~/.gpg-agent-info)}"
else
  start-gpg
fi

if [[ -n "$GPG_AGENT_INFO" && ! "$(ps -p ${${(ps/:/)GPG_AGENT_INFO}[2]})" =~ '\sgpg-agent\s' ]]; then
  start-gpg
fi

unfunction start-gpg

export GPG_TTY=$(tty)
