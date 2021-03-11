if (( $+commands[go] )); then
  export GOPATH=~/Projects/gocode
  path[2,1]=$GOPATH:q/bin
  for prog ($GOPATH:q/bin/*(.:tx)) alias ${prog}="env -u DYLD_INSERT_LIBRARIES $prog"
  unset prog
  export GONOPROXY=git.vertiv.life
  export GONOSUMDB=git.vertiv.life
fi
