if [[ -n "$XDG_RUNTIME_DIR" ]]; then
  # export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  . $XDG_RUNTIME_DIR/upstart/sessions/*.session(oc[1])
  if [[ -n "$UPSTART_SESSION" ]]; then
    export UPSTART_SESSION
  fi
fi
