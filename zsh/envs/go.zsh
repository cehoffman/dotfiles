if (( $+commands[go] )); then
  export GOPATH=~/Projects/gocode
  path[2,1]=$GOPATH:q/bin
  export GONOPROXY=git.vertiv.life
  export GONOSUMDB=git.vertiv.life
fi
