function {
  if [[ -n "$XDG_RUNTIME_DIR" ]]; then
    local session="$(echo $XDG_RUNTIME_DIR/upstart/sessions/*.session(oc[1]))"
    [[ -n "$session" ]] && source "$session"
    [[ -n "$UPSTART_SESSION" ]] && export UPSTART_SESSION
  fi
}
