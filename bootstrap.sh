#!/usr/bin/env sh
#
# Only use sudo if not already root.
#
if (( $UID == 0 )); then sudo=""
else                     sudo="sudo"
fi

#
# Prints a warn message.
#
warn()
{
  if [ -t 1 ]; then
    echo -e "\e[1m\e[33m***\e[0m \e[1m$1\e[0m" >&2
  else
    echo "*** $1" >&2
  fi
}

#
# Prints an error message.
#
error()
{
  if [ -t 1 ]; then
    echo -e "\e[1m\e[31m!!!\e[0m \e[1m$1\e[0m" >&2
  else
    echo "!!! $1" >&2
  fi
}

#
# Prints an error message and exists with -1.
#
fail()
{
  error "$*"
  exit -1
}

os=$(uname -s | tr A-Z a-z)

set -e

export PATH="$HOME/.homebrew/bin:$PATH"

case $os in
  darwin)
    xcode-select --install
    ;;
  linux)
    $sudo apt-get install build-essential curl libexpat-dev git
    ;;
  *) fatal "Unknown system, don't know how to bootstrap" ;;
esac

case $os in
  darwin)
    if [ ! -d ~/.homebrew ]; then
      git clone --recursive git@github.com:homebrew/homebrew ~/.homebrew 
    fi
    brew install cehoffman/encfs htop
    ;;
  linux)
    if [ ! -d ~/.homebrew ]; then
      git clone --recursive git@github.com:homebrew/linuxbrew ~/.homebrew 
    fi

    echo "$USER ALL= NOPASSWD: ALL" | $sudo tee "/etc/sudoers.d/$USER" > /dev/null
    $sudo chmod 440 "/etc/sudoers.d/$USER"
    $sudo passwd -l "$USER"

    # Install deps for ruby
    $sudo apt-get install libssl-dev libcurl4-openssl-dev libbz2-dev htop
    ;;
esac

brew install git zsh ctags
brew tap cehoffman/personal
brew install cpanminus stderred

if [ ! -d ~/.dotfiles ]; then
  git clone --recursive git@github.com:cehoffman/dotfiles ~/.dotfiles 
fi
sed -e "\$a$HOME/.homebrew/bin/zsh" /etc/shells | $sudo tee /etc/shells > /dev/null

zsh -c 'rbenv install 2.1.1'
zsh -c 'rbenv global 2.1.1'

zsh -c 'luaenv install luajit-2.1.0-alpha'
zsh -c 'luaenv global luajit-2.1.0-alpha'

install_packages libreadline-dev libsqlite3-dev
zsh -c 'pyenv install 2.7.6'
zsh -c 'pyenv global 2.7.6'

~/.dotfiles/link.sh
