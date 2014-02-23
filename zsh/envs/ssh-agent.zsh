if [[ -o interactive && -n $TMUX ]]; then
  function sync-ssh-auth-sock() {
    local NEW_SSH_AUTH_SOCK=$(command tmux showenv| grep \^SSH_AUTH_SOCK | cut -d = -f 2)
    if [[ -n $NEW_SSH_AUTH_SOCK && -S $NEW_SSH_AUTH_SOCK ]]; then
      export SSH_AUTH_SOCK="$NEW_SSH_AUTH_SOCK"
    fi
  }
fi
