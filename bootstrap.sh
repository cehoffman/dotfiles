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
warn() {
  if [ -t 1 ]; then
    echo -e "\e[1m\e[33m***\e[0m \e[1m$1\e[0m" >&2
  else
    echo "*** $1" >&2
  fi
}

#
# Prints an error message.
#
error() {
  if [ -t 1 ]; then
    echo -e "\e[1m\e[31m!!!\e[0m \e[1m$1\e[0m" >&2
  else
    echo "!!! $1" >&2
  fi
}

#
# Prints an error message and exists with -1.
#
fail() {
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
  rm -rf ~/.homebrew/share/doc/homebrew
  brew update
fi

case $os in
  darwin)
    ;;
  linux)
    echo "$USER ALL= NOPASSWD: ALL" | $sudo tee "/etc/sudoers.d/$USER" > /dev/null
    $sudo chmod 440 "/etc/sudoers.d/$USER"
    $sudo passwd -l "$USER"

    # Install deps for ruby
    $sudo apt-get install -y zlib1g-dev
    # Install deps for python
    $sudo apt-get install -y libssl-dev libbz2-dev
    # Install personal utilities
    $sudo apt-get install -y htop
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
    git --git-dir ~/.dotfiles/.git commit -m "Remove private git submodules"
  fi
  cd ~/.dotfiles
  git submodule update --init --recursive
  cd $OLDPWD
fi
~/.dotfiles/bin/relink

brew install readline openssl
brew install zsh --with-pcre --with-unicode9

if [ -z "$(grep "$HOME/\\.homebrew/bin/zsh" /etc/shells)" ]; then
  sed -e "\$a$HOME/.homebrew/bin/zsh" /etc/shells | $sudo tee /etc/shells > /dev/null
fi
$sudo chsh -s "$HOME/.homebrew/bin/zsh" "$USER"

if [ "$os" = "linux" ]; then
  # Install tcl deps for git without problematic tk
  brew install tcl-tk --without-tk
elif [ "$os" = "darwin" ]; then
  brew install reattach-to-user-namespace htop
fi
brew install git --with-pcre2 --with-persistent-https --with-openssl --with-curl --with-perl
brew install gnu-tar --with-default-names
brew install gnu-sed --with-default-names
brew install git-extras tmux the_silver_searcher coreutils cmake ctags tree pstree

version=2.5.0
if [ ! -d $HOME/.rbenv/versions/$version ]; then
  zsh -c "rbenv install $version"
  zsh -c "rbenv global $version"
fi

version=2.7.14
if [ ! -d $HOME/.pyenv/versions/$version ]; then
  zsh -c "PYTHON_CONFIGURE_OPTS='--enable-shared' CFLAGS='-I$(brew --prefix openssl)/include' LDFLAGS='-L$(brew --prefix openssl)/lib' pyenv install $version"
  zsh -c "pyenv global $version"
  zsh -c "pip install --upgrade pip && pip install httpie"
fi

version=9.5.0
if [ ! -d $HOME/.nodenv/versions/$version ]; then
  zsh -c "nodenv install $version"
  zsh -c "nodenv global $version"
fi

if [ "$os" = "linux" ]; then
  # Install single key read for git add --patch
  cpan -i Term::ReadKey
fi

# Unlink pkg-config brought in by tmux
brew unlink pkg-config

version=luajit-2.1.0-beta3
if [ ! -d $HOME/.luaenv/versions/$version ]; then
  zsh -c "luaenv install $version"
  ln -sf $version $HOME/.luaenv/versions/2.1.0
  zsh -c "luaenv global 2.1.0"
fi

# Run this in zsh to have pyenv setup so vim finds python
zsh -c 'brew install python --with-unicode-ucs4 --without-tcl-tk'
zsh -c 'brew install vim --with-luajit'

~/.dotfiles/bin/update

vim +BundleInstall '+qa!'

zsh -c "cd '$HOME/.vim/bundle/YouCompleteMe' && ./install.py --clang-completer --gocode-completer --js-completer"
