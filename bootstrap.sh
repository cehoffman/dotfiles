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

export PATH="$HOME/.homebrew/bin:$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"

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
    ;;
  linux)
    if [ ! -d ~/.homebrew ]; then
      git clone --recursive git@github.com:homebrew/linuxbrew ~/.homebrew 
    fi

    echo "$USER ALL= NOPASSWD: ALL" | $sudo tee "/etc/sudoers.d/$USER" > /dev/null
    $sudo chmod 440 "/etc/sudoers.d/$USER"
    $sudo passwd -l "$USER"

    # Install deps for ruby
    $sudo apt-get install libssl-dev libcurl4-openssl-dev libbz2-dev
    # Install deps for zsh
    $sudo apt-get install ncurses-dev
    # Install personal utilities
    $sudo apt-get install htop
    # Install deps for python
    $sudo apt-get install libreadline-dev libsqlite3-dev
    ;;
esac

if [ ! -d ~/.dotfiles ]; then
  git clone --recursive git@github.com:cehoffman/dotfiles ~/.dotfiles 
fi
~/.dotfiles/link.sh

version=2.1.1
if [ ! -d $HOME/.rbenv/versions/$version ]; then
  rbenv install $version
  rbenv global $version
fi

brew tap cehoffman/personal
brew install git zsh ctags cpanminus stderred

if [ "$os" = "darwin" ]; then
  brew install cehoffman/personal/encfs htop
fi

# Make use of newly installed ctags to index ruby
rbenv ctags

version=luajit-2.1.0-alpha
if [ ! -d $HOME/.luaenv/versions/$version ]; then
  zsh -c "luaenv install $version"
  zsh -c "luaenv global $version"
fi

version=2.7.6
if [ ! -d $HOME/.pyenv/versions/$version ]; then
  case $os in
    darwin)
      opts="--enable-framework"
      ;;
    linux)
      opts="--enable-shared"
      ;;
  esac
  zsh -c "PYTHON_CONFIGURE_OPTS='$opts' pyenv install $version"
  zsh -c "pyenv global $version"
  unset opts
fi
unset version

~/.dotfiles/link.sh

if grep "$HOME/\\.homebrew/bin/zsh" /etc/shells > /dev/null ; then
  sed -e "\$a$HOME/.homebrew/bin/zsh" /etc/shells | $sudo tee /etc/shells > /dev/null
fi
$sudo chsh -s "$HOME/.homebrew/bin/zsh" "$USER"

zsh -c 'brew install cehoffman/personal/vim'
