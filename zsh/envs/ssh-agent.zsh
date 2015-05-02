if [[ -o interactive && -n $TMUX ]]; then
  function sync-ssh-auth-sock() {
    local NEW_SSH_AUTH_SOCK="$(command tmux showenv| grep \^SSH_AUTH_SOCK | cut -d = -f 2)"
    if [[ -n "$NEW_SSH_AUTH_SOCK" && -S "$NEW_SSH_AUTH_SOCK" ]]; then
      export SSH_AUTH_SOCK="$NEW_SSH_AUTH_SOCK"
    fi
  }

  function __sync_ssh_auth_sock() {
    # If inside a tmux session and the auth socket is no longer viable, update
    if [[ -n "$TMUX" && ! -S "$SSH_AUTH_SOCK" ]]; then
      sync-ssh-auth-sock
    fi
  }
  precmd_functions+=__sync_ssh_auth_sock
fi
