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
    $sudo apt-get install -y libssl-dev libcurl4-openssl-dev libbz2-dev libffi-dev
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
    ;;
esac

if [ ! -d ~/.dotfiles ]; then
  git clone --recursive git@github.com:cehoffman/dotfiles ~/.dotfiles
fi
~/.dotfiles/bin/relink

version=2.2.2
if [ ! -d $HOME/.rbenv/versions/$version ]; then
  rbenv install $version
  rbenv global $version
fi

zsh -c "brew install openssl"

version=2.7.10
if [ ! -d $HOME/.pyenv/versions/$version ]; then
  case $os in
    darwin)
      zsh -c "PYTHON_CONFIGURE_OPTS=\"--enable-framework\" CFLAGS=\"-I$(brew --prefix openssl)/include\" LDFLAGS=\"-L$(brew --prefix openssl)/lib\" pyenv install $version"
      ;;
    linux)
      zsh -c "CFLAGS='-fPIC' pyenv install $version"
      ;;
  esac
  zsh -c "pyenv global $version"
  unset opts
fi

version=4.2.1
if [ ! -d $HOME/.nodenv/versions/$version ]; then
  zsh -c "nodenv install $version"
  zsh -c "nodenv global $version"
fi

brew tap cehoffman/personal
if [ "$os" = "linux" ]; then
  # Install tcl deps for git without problematic tk
  brew install tcl-tk --without-tk
fi
brew install git zsh ctags cpanminus stderred tmux the_silver_searcher

if [ "$os" = "linux" ]; then
  # Install single key read for git
  cpanm Term::ReadKey
fi

# Unlink pkg-config brought in by tmux
brew unlink pkg-config

if [ "$os" = "darwin" ]; then
  brew install cehoffman/personal/encfs htop
else
  # Remove liblzma installed from the_silver_searcher to avoid conflict with
  # system
  if brew list | grep -iq xz; then
    brew remove xz
  fi
fi

# Make use of newly installed ctags to index ruby
rbenv ctags

version=luajit-2.1.0-alpha
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
zsh -c 'brew install vim'

# Setup ldconfig so zsh can find pcre on login
if [ "$os" = "linux" ]; then
  echo $HOME/.homebrew/lib | $sudo tee /etc/ld.so.conf.d/${USER}.conf > /dev/null
  chmod 700 $HOME
  $sudo ldconfig
fi

~/.dotfiles/bin/update

vim +BundleInstall '+qa!'

ycm="$HOME/.vim/bundle/YouCompleteMe"
case $os in
  darwin)
    zsh -c "cd '$ycm' && PYENV_VERSION=$version ./install.sh --clang-completer"
    zsh -c $'install_name_tool -change ${${(z)${"${(f)$(otool -L =vim)}"[(r)*Python*]}}[1]} ~/.pyenv/versions/'$version'/lib/libpython*.dylib =vim'
    ;;
  linux)
    cd "$ycm"
    sed -i 's/Unix Makefiles"/Unix Makefiles" \$(python_finder)/' third_party/ycmd/build.sh
    zsh -c "cd '$ycm' && chmod +x ./install.sh && PYENV_VERSION=$version ./install.sh --clang-completer"
    cd "third_party/ycmd"
    git checkout build.sh
    ;;
esac

