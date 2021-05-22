if [[ -d ~/.gnupg ]] && (( $+commands[gpgconf] )); then
  export GPG_TTY=$(tty)
  gpgconf --launch gpg-agent # This requires at least 2.1
  # export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh
fi
