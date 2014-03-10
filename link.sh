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

case $(uname -s) in
  [dD]arwin*)
    PLATFORM=darwin
    ;;
  [lL]inux*)
    PLATFORM=linux
    ;;
  *[cC]ygwin*)
    PLATFORM=cygwin
    ;;
  *)
    ;;
esac

link() {
  src=".dotfiles/$file"
  dest="$HOME/.$file"

  if [ -e "$dest" -a "$(readlink "$dest")" = "$src" ]; then
    return
  fi

  printf "Linking %s -> %s\n" "$(echo $dest | sed -e "s:$HOME:~:")" "$src"
  if [ -d $file ]; then
    if [ -z "$DRY_RUN" ]; then
      ln -sfT "$src" "$dest"
    fi
  else
    if [ -z "$DRY_RUN" ]; then
      ln -sfT "$src" "$dest"
    fi
  fi

  unset src
  unset dest
}

test_link() {
  if command -v "$1" > /dev/null 2>&1; then
    link "$2"
  fi
}

platform_link() {
  if [ $PLATFORM = $1 ]; then
    link "$2"
  fi
}

###########################################################################
#                      Remove All links to dotfiles                       #
###########################################################################

for file in $HOME/.*; do
  if [ -h "$file" ]; then
    case "$(readlink "$file")" in
      .dotfiles/*)
        if [ -z "$DRY_RUN" ]; then
          rm -f "$file"
        fi
        ;;
    esac
  fi
  # Removes only broken links
  # if [ -h "$file" -a ! -e "$file" ]; then
  #   printf "Removing broken link %s\n" "$file"
  #   if [ -z "$DRY_RUN" ]; then
  #     rm -f "$file"
  #   fi
  # fi
done

for file in $(dirname "$0")/*; do
  file=$(basename "$file")
  case $file in
    Readme.md|os|zsh|mutt|mailcap|irb|vim|gitignore|cacerts|fonts|offlineimap)
      ;;
    bootstrap.sh|link.sh|update.sh|helpers.rb)
      ;;
    editrc)
      platform_link darwin "$file"
      ;;
    ctags)
      test_link ctags "$file"
      ;;
    elinks)
      test_link elinks "$file"
      ;;
    gvimrc)
      test_link gvim "$file"
      test_link mvim "$file"
      ;;
    tmux.conf)
      test_link tmux "$file"
      ;;
    offlineimaprc)
      test_link offlineimap "$file"
      ;;
    muttrc)
      test_link mutt "$file"
      ;;
    msmtprc)
      test_link msmtp "$file"
      ;;
    js)
      test_link djsd "$file"
      ;;
    irbrc|rspec|rdebugrc|gemrc)
      test_link ruby "$file"
      ;;
    htoprc)
      test_link htop "$file"
      ;;
    ackrc)
      test_link ack "$file"
      test_link ag "$file"
      ;;
    minttyrc)
      platform_link cygwin "$file"
      ;;
    screenrc)
      test_link screen "$file"
      ;;
    lbdbrc)
      test_link lbdb "$file"
      ;;
    *.erb)
      GENERATE=
      case ${file%.*} in
        mailrc)
          if command -v msmtpq > /dev/null 2>&1; then
            GENERATE=true
          fi
          ;;
        notmuch-config)
          if command -v notmuch > /dev/null 2>&1; then
            GENERATE=true
          fi
          ;;
        gitconfig)
          if command -v git > /dev/null 2>&1; then
            GENERATE=true
          fi
          ;;
      esac
      if [ -n "$GENERATE" ]; then
        if command -v erb > /dev/null 2>&1; then
          echo "Generating ~/.${file%.*}"
          if [ -z "$DRY_RUN" ]; then
            erb -r "$(dirname $0)/helpers" "$(dirname $0)/$file" > "$HOME/.${file%.*}"
          fi
        fi
      fi
      unset GENERATE
      ;;
    *)
      link "$file"
    ;;
  esac
done