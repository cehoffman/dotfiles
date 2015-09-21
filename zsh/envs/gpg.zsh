export GPG_TTY=$(tty)

if [[ -d "/Volumes/GPG Backup/gnupghome" ]]; then
  export GNUPGHOME="/Volumes/GPG Backup/gnupghome"
else
  export GNUPGHOME="$HOME/.gnupg"
fi

[[ -S "$GNUPGHOME/S.gpg-agent" ]] || gpg-agent --daemon --enable-ssh-support &> /dev/null
export SSH_AUTH_SOCK="$GNUPGHOME/S.gpg-agent.ssh"
