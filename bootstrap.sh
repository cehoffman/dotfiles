#!/usr/bin/env sh
#
# Only use sudo if not already root.
#
if [ "$UID" = "0" ]; then
	sudo=""
else
	sudo="sudo"
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

	# Disable accents menu on key hold
	defaults write -g ApplePressAndHoldEnabled -bool false
	;;
linux)
	echo "$USER ALL= NOPASSWD: ALL" | $sudo tee "/etc/sudoers.d/$USER" >/dev/null
	$sudo chmod 440 "/etc/sudoers.d/$USER"
	$sudo passwd -l "$USER"

	# Install deps for ruby
	$sudo apt-get install -y zlib1g-dev
	# Install deps for python
	$sudo apt-get install -y libssl-dev libbz2-dev
	# Install personal utilities
	$sudo apt-get install -y btop
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

brew install readline openssl direnv zsh

if [ -z "$(grep "$HOME/\\.homebrew/bin/zsh" /etc/shells)" ]; then
	{
		cat /etc/shells
		echo "$HOME/.homebrew/bin/zsh"
	} | $sudo tee /etc/shells >/dev/null
fi
$sudo chsh -s "$HOME/.homebrew/bin/zsh" "$USER"

if [ "$os" = "linux" ]; then
	# Install tcl deps for git without problematic tk
	brew install tcl-tk
fi
brew tap cehoffman/personal
brew install git gnu-tar gnu-sed git-extras tmux ripgrep coreutils cmake tree pstree luajit neovim jq stderred exa bat btop

if [ "$os" = "linux" ]; then
	# Install single key read for git add --patch
	cpan -i Term::ReadKey
fi

# Install casks
if [ "$os" = "mac" ]; then
  brew install wezterm
fi

version_for() {
  grep "$1" "$(dirname "${BASH_SOURCE[0]:-$0}"; pwd -P)/tool-versions" | awk '{print $2}'
}

version=$(version_for ruby)
if [ ! -d $HOME/.asdf/installs/ruby/$version ]; then
	asdf plugin-add ruby
	zsh -c "asdf install ruby $version"
	asdf global ruby $version
fi

version=$(version_for python)
if [ ! -d $HOME/.asdf/installs/python/$version ]; then
	asdf plugin-add python
	brew unlink gettext
	zsh -c "asdf install python $version"
	brew link gettext
	asdf global python $version
	zsh -c "pip install --upgrade pip && pip install httpie && asdf reshim python"
fi

version=$(version_for nodejs)
if [ ! -d $HOME/.asdf/installs/nodejs/$version ]; then
	asdf plugin-add nodejs
	zsh -c "~/.asdf/plugins/nodejs/bin/import-release-team-keyring"
	zsh -c "asdf install nodejs $version"
	asdf global nodejs $version
fi

version=$(version_for erlang)
if [ ! -d $HOME/.asdf/installs/erlang/$version ]; then
	asdf plugin-add erlang
	# Required because sql.h and sqlext.h are installed by unixodbc, but
	# configure does not add the with-odbc path to search for these headers
	$sudo ln -sfT $HOME/.homebrew/include /usr/local/include
	zsh -c "KERL_CONFIGURE_OPTIONS='--with-odbc=$HOME/.homebrew/opt/unixodbc --enable-dynamic-ssl-lib --with-ssl=$HOME/.homebrew/opt/openssl@1.1 --enable-sctp --enable-shared-zlib --without-javac --with-dynamic-trace=dtrace --enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --enable-darwin-64bit' asdf install erlang $version"
	asdf global erlang $version
fi

version=$(version_for elixir)
if [ ! -d $HOME/.asdf/installs/elixir/$version ]; then
	asdf plugin-add elixir
	zsh -c "asdf install elixir $version"
	asdf global elixir $version
fi

version=$(version_for golang)
if [ ! -d $HOME/.asdf/installs/golang/$version ]; then
	asdf plugin-add golang
	zsh -c "asdf install golang $version"
	asdf global golang $version
fi

version=$(version_for kubectl)
if [ ! -d $HOME/.asdf/installs/kubectl/$version ]; then
	asdf plugin-add kubectl
	zsh -c "asdf install kubectl $version"
	asdf global kubectl $version
fi

~/.dotfiles/bin/update
