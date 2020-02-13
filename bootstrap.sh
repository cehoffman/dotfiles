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

export PATH="$HOME/.homebrew/bin:$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"

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
  curl -LsSf https://github.com/Homebrew/brew/tarball/master | tar --strip-components=1 -zxf - -C ~/.homebrew
  brew update
fi

case $os in
  darwin)
    # erlang/elixir nice to haves
    brew install freetds unixodbc wxmac
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
    # Useful system utilties to have
    $sudo apt-get install -y net-tools procps iputils-ping

    # Tool necessary to compile tools outside of brew
    $sudo apt-get install -y autoconf libtool libncurses5-dev

    # erlang/elixir nice to have
    brew install freetds unixodbc
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
    git --git-dir ~/.dotfiles/.git config --local user.email cehoffman@gmail.com
    git --git-dir ~/.dotfiles/.git config --local user.name "Chris Hoffman"
    git --git-dir ~/.dotfiles/.git commit -m "Remove private git submodules"
    git --git-dir ~/.dotfiles/.git config --local --unset user.email
    git --git-dir ~/.dotfiles/.git config --local --unset user.name "Chris Hoffman"
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
brew install python --with-unicode-ucs4 --without-tcl-tk
brew install git-extras tmux the_silver_searcher coreutils cmake ctags tree pstree vim jq

# Run this in zsh to have pyenv setup so vim finds python
zsh -c 'brew install vim --with-luajit'

if [ "$os" = "linux" ]; then
  # Install single key read for git add --patch
  cpan -i Term::ReadKey
fi

version=2.0.3--2.4.2
if [ ! -d $HOME/.asdf/installs/luaJIT/$version ]; then
  asdf plugin-add luaJIT
  zsh -c "asdf install luaJIT $version"
  asdf global luaJIT $version
fi

version=2.5.0
if [ ! -d $HOME/.asdf/installs/ruby/$version ]; then
  asdf plugin-add ruby
  zsh -c "asdf install ruby $version"
  asdf global ruby $version
fi

version=2.7.14
if [ ! -d $HOME/.asdf/installs/python/$version ]; then
  asdf plugin-add python
  zsh -c "PYTHON_CONFIGURE_OPTS='--enable-shared' CFLAGS='-I$(brew --prefix openssl)/include' LDFLAGS='-L$(brew --prefix openssl)/lib' asdf install python $version"
  asdf global python $version
  zsh -c "pip install --upgrade pip && pip install httpie && asdf reshim python"
fi

version=9.5.0
if [ ! -d $HOME/.asdf/installs/nodejs/$version ]; then
  asdf plugin-add nodejs
  zsh -c "~/.asdf/plugins/nodejs/bin/import-release-team-keyring"
  zsh -c "asdf install nodejs $version"
  asdf global nodejs $version
fi

version=20.3.2
if [ ! -d $HOME/.asdf/installs/erlang/$version ]; then
  asdf plugin-add erlang
  asdf install erlang $version
  asdf global erlang $version
fi

version=1.6.4-otp-20
if [ ! -d $HOME/.asdf/installs/elixir/$version ]; then
  asdf plugin-add elixir
  zsh -c "asdf install elixir $version"
  asdf global elixir $version
fi

version=1.10
if [ ! -d $HOME/.asdf/installs/golang/$version ]; then
  asdf plugin-add golang 
  zsh -c "asdf install golang $version"
  asdf global golang $version
fi

asdf plugin-add kubectl
version=1.8.7
if [ ! -d $HOME/.asdf/installs/kubectl/$version ]; then
  asdf plugin-add kubectl 
  zsh -c "asdf install kubectl $version"
  asdf global kubectl $version
fi

~/.dotfiles/bin/update

vim +BundleInstall '+qa!'
zsh -c "cd '$HOME/.vim/bundle/YouCompleteMe' && ./install.py --clang-completer --gocode-completer --js-completer"
