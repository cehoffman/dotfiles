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

if [ ! -d ~/.homebrew ]; then
  mkdir ~/.homebrew
  curl -LsSf https://github.com/Homebrew/homebrew/tarball/master | tar --strip-components=1 -zxf - -C ~/.homebrew
  brew update
fi

case $os in
  darwin)

    # Install readline so ruby has it
    brew install readline
    ;;
  linux)
    echo "$USER ALL= NOPASSWD: ALL" | $sudo tee "/etc/sudoers.d/$USER" > /dev/null
    $sudo chmod 440 "/etc/sudoers.d/$USER"
    $sudo passwd -l "$USER"

    # Install deps for ruby
    $sudo apt-get install -y libssl-dev libcurl4-openssl-dev libbz2-dev libffi-dev zlib1g-dev
    # Install deps for zsh
    $sudo apt-get install -y ncurses-dev texinfo
    # Install personal utilities
    $sudo apt-get install -y htop
    # Install deps for python
    $sudo apt-get install -y libreadline-dev libsqlite3-dev python-setuptools
    # Install deps for git from homebrew
    $sudo apt-get install -y tcl
    # Install deps for the_silver_searcher
    $sudo apt-get install -y autoconf
    # Need zsh to bootstrap zsh
    $sudo apt-get install -y zsh
    ;;
esac

if [ ! -d ~/.dotfiles ]; then
  git clone https://github.com/cehoffman/dotfiles ~/.dotfiles
  if [ -n "${PUBLIC}" ]; then
    sed '/js/d' -i ~/.dotfiles/.gitmodules
    git --git-dir ~/.dotfiles/.git rm -r ssh
    sed '/js/d' -i ~/.dotfiles/.gitmodules
    git --git-dir ~/.dotfiles/.git rm -r js
    git --git-dir ~/.dotfiles/.git add .gitmodules
  fi
  cd ~/.dotfiles
  git submodule update --init --recursive
  cd $OLDPWD
fi
~/.dotfiles/bin/relink

zsh -c "brew install ctags openssl"

version=2.5.0
if [ ! -d $HOME/.rbenv/versions/$version ]; then
  rbenv install $version
  rbenv global $version
fi

version=2.7.14
if [ ! -d $HOME/.pyenv/versions/$version ]; then
  case $os in
    darwin)
      zsh -c "PYTHON_CONFIGURE_OPTS=\"--enable-framework\" CFLAGS=\"-I$(brew --prefix openssl)/include\" LDFLAGS=\"-L$(brew --prefix openssl)/lib\" pyenv install $version"
      ;;
    linux)
      zsh -c "PYTHON_CONFIGURE_OPTS='--enable-shared' CFLAGS='-fPIC -I$(brew --prefix openssl)/include' LDFLAGS='-L$(brew --prefix openssl)/lib' pyenv install $version"
      ;;
  esac
  zsh -c "pyenv global $version"
  unset opts
fi

version=9.5.0
if [ ! -d $HOME/.nodenv/versions/$version ]; then
  zsh -c "nodenv install $version"
  zsh -c "nodenv global $version"
fi

if [ "$os" = "linux" ]; then
  # Install tcl deps for git without problematic tk
  brew install tcl-tk --without-tk
elif [ "$os" = "darwin" ]; then
  brew install reattach-to-user-namespace htop
fi
brew install git --with-pcre2 --with-persistent-https --with-openssl --with-curl --with-perl
brew install zsh --with-pcre --with-unicode9
brew install git-extras cpanminus tmux the_silver_searcher gnu-sed gnu-tar cmake


if [ "$os" = "linux" ]; then
  # Install single key read for git add --patch
  cpan -i Term::ReadKey
fi

# Unlink pkg-config brought in by tmux
brew unlink pkg-config

version=luajit-2.1.0-beta1
if [ ! -d $HOME/.luaenv/versions/$version ]; then
  zsh -c "luaenv install $version"
  ln -sf $version $HOME/.luaenv/versions/2.1.0
  zsh -c "luaenv global 2.1.0"
fi

if [ -z "$(grep "$HOME/\\.homebrew/bin/zsh" /etc/shells)" ]; then
  sed -e "\$a$HOME/.homebrew/bin/zsh" /etc/shells | $sudo tee /etc/shells > /dev/null
fi
$sudo chsh -s "$HOME/.homebrew/bin/zsh" "$USER"

# Run this in zsh to have pyenv setup so vim finds python
zsh -c 'brew install python --with-unicode-ucs4 --without-tcl-tk'
zsh -c 'brew install vim --with-luajit'

~/.dotfiles/bin/update

vim +BundleInstall '+qa!'

zsh -c "cd '$HOME/.vim/bundle/YouCompleteMe' && ./install.py --clang-completer --gocode-completer --js-completer"
