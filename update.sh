#!/usr/bin/env sh

set -- $(getopt n "$@")

while true; do
  case $1 in
    -n)
      DRY_RUN=true; shift; continue
      ;;
    --)
      break
      ;;
    *)
      echo "Unknown option \"$1\""
      exit 1
      ;;
  esac
done

set -- "$@"

cd ~/.dotfiles

git_update() {
  git pull --rebase
  git submodule sync
  git submodule update --init --recursive
}

if [ -z "$DRY_RUN" ]; then
  git diff-index --quiet HEAD
  if [ $? = 0 ]; then
    git_update
  else
    git stash
    git_update
    git stash pop
  fi
fi

case $PLATFORM in
  darwin)
    if [ -z "$DRY_RUN" ]; then
      if command -v rake > /dev/null 2>&1; then
        cd os/mac
        rake install
      fi
    fi
    ;;
  linux)
    ;;
  cygwin)
    ;;
esac

$(dirname "$0")/link.sh

if command -v vim > /dev/null 2>&1; then
  if [ -z "$DRY_RUN" ]; then
    if [ -n "$(git diff HEAD@{1}...HEAD -- vimrc)" ]; then
      vim +BundleInstall +BundleClean! +BundleUpdate +qa
    fi
  fi
fi
