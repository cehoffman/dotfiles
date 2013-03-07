if [[ -n $TMUX ]]; then
  function sync-ssh-auth-sock() {
    local NEW_SSH_AUTH_SOCK=$(command tmux showenv| grep \^SSH_AUTH_SOCK | cut -d = -f 2)
    if [[ -n $NEW_SSH_AUTH_SOCK && -S $NEW_SSH_AUTH_SOCK ]]; then
      export SSH_AUTH_SOCK="$NEW_SSH_AUTH_SOCK"
    fi
  }
fi

if [[ -z "$SSH_AUTH_SOCK" ]]; then
  [[ -f ~/.ssh-agent ]] && source ~/.ssh-agent

  # If the agent isn't running or hasn't ever been set for this account
  if [[ -z "$SSH_AGENT_PID" || "$(ps -p $SSH_AGENT_PID &> /dev/null; echo $?)" != "0" ]]; then
    # start the agent and delete the last line (the echo line) and save to file
    eval $(umask 066 && ssh-agent | sed '$d' | tee ~/.ssh-agent)
  fi
fi
