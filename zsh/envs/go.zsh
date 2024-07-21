if (( $+commands[go] )); then
  export GOPATH=~/Projects/gocode
  path[2,1]=$GOPATH:q/bin
  export GONOPROXY=git.ceh.im
  export GONOSUMDB=git.ceh.im

  # Don't use go.mod to determine ASDF go version to use
  export ASDF_GOLANG_MOD_VERSION_ENABLED=false
fi
