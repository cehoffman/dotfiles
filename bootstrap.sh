#!/usr/bin/env sh
#
# Only use sudo if not already root.
#
if [ "$UID" = "0" ]; then sudo=""
else                 sudo="sudo"
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
    $sudo apt-get install -y build-essential curl libexpat-dev git
    ;;
  *) fatal "Unknown system, don't know how to bootstrap" ;;
esac

case $os in
  darwin)
    if [ ! -d ~/.homebrew ]; then
      git clone --recursive git@github.com:homebrew/homebrew ~/.homebrew 
    fi

    # Install readline so ruby has it
    brew install readline
    ;;
  linux)
    if [ ! -d ~/.homebrew ]; then
      git clone --recursive git@github.com:homebrew/linuxbrew ~/.homebrew 
    fi

    echo "$USER ALL= NOPASSWD: ALL" | $sudo tee "/etc/sudoers.d/$USER" > /dev/null
    $sudo chmod 440 "/etc/sudoers.d/$USER"
    $sudo passwd -l "$USER"

    # Install deps for ruby
    $sudo apt-get install -y libssl-dev libcurl4-openssl-dev libbz2-dev
    # Install deps for zsh
    $sudo apt-get install -y ncurses-dev texinfo
    # Install personal utilities
    $sudo apt-get install -y htop
    # Install deps for python
    $sudo apt-get install -y libreadline-dev libsqlite3-dev
    # Install deps for git from homebrew
    $sudo apt-get install -y tcl
    # Install deps for the_silver_searcher
    $sudo apt-get install -y autoconf
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
brew install git zsh ctags cpanminus stderred tmux the_silver_searcher

# Unlink pkg-config brought in by tmux
brew unlink pkg-config

if [ "$os" = "darwin" ]; then
  brew install cehoffman/personal/encfs htop
else
  # Remove liblzma installed from the_silver_searcher to avoid conflict with
  # system
  brew remove xz
fi

# Make use of newly installed ctags to index ruby
rbenv ctags

version=luajit-2.1.0-alpha
if [ ! -d $HOME/.luaenv/versions/$version ]; then
  zsh -c "luaenv install $version"
  ln -sf $version $HOME/.luaenv/versions/2.1.0
  zsh -c "luaenv global 2.1.0"
fi

version=2.7.6
if [ ! -d $HOME/.pyenv/versions/$version ]; then
  case $os in
    darwin)
      zsh -c "PYTHON_CONFIGURE_OPTS='--enable-framework' pyenv install $version"
      ;;
    linux)
      zsh -c "CFLAGS='-fPIC' pyenv install $version"
      ;;
  esac
  zsh -c "pyenv global $version"
  unset opts
fi

if grep "$HOME/\\.homebrew/bin/zsh" /etc/shells > /dev/null ; then
  sed -e "\$a$HOME/.homebrew/bin/zsh" /etc/shells | $sudo tee /etc/shells > /dev/null
fi
$sudo chsh -s "$HOME/.homebrew/bin/zsh" "$USER"

# Run this in zsh to have pyenv setup so vim finds python
zsh -c 'brew install cehoffman/personal/vim'

# Setup ldconfig so zsh can find pcre on login
if [ "$os" = "linux" ]; then
  echo $HOME/.homebrew/lib | $sudo tee /etc/ld.so.conf.d/${USER}.conf > /dev/null
  chmod 700 $HOME
  $sudo ldconfig
fi

~/.dotfiles/update.sh

vim +BundleInstall '+qa!'
cd ~/.vim/bundle/YouCompleteMe
zsh -c "PYENV_VERSION=$version ./install.sh --clang-completer"

