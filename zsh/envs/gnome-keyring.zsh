if [[ -x $(which gnome-keyring-daemon) ]]; then
  [[ -f ~/.dbus-daemon ]] && source ~/.dbus-daemon
  [[ -f ~/.gnome-keyring-daemon ]] && export $(cat ~/.gnome-keyring-daemon)

  if [[ -z "$DBUS_SESSION_BUS_PID" || "$(kill -0 $DBUS_SESSION_BUS_PID &> /dev/null ; echo $?)" != "0" ]]; then
    # gnome-keyring needs dbus for communication
    eval $(umask 066 && dbus-launch --sh-syntax | tee ~/.dbus-daemon)
  fi

  if [[ -z "$GNOME_KEYRING_PID" || "$(kill -0 $GNOME_KEYRING_PID &> /dev/null ; echo $?)" != "0" ]]; then
    # Let ssh-agent/gpg-agent take control of their tasks
    export $(umask 066 && gnome-keyring-daemon --components=pkcs11,secrets | tee ~/.gnome-keyring-daemon)
  fi
fi
