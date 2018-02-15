if (( $+commands[go] )); then
  export GOPATH=~/Projects/gocode
  path[1,0]=$GOPATH:q/bin
  for prog ($GOPATH:q/bin/*(.:tx)) alias ${prog}="env -u DYLD_INSERT_LIBRARIES $prog"
  unset prog
fi
