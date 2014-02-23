if command -v go &> /dev/null; then
  for dir ($(go env GOROOT)/bin/*(/)) { dir=$(basename $dir); eval "alias go-${dir%_*}-${dir#*_}=\"GOOS=${dir%_*} GOARCH=${dir#*_} go\"" }
  unset dir
  export GOPATH=~/Projects/gocode
  path=($GOPATH/bin $path)
fi
