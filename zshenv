# The file load order is
#
# Always read
#   global zshenv
#   .zshenv (except zsh -f which only read global zshenv)
#
# If login shell
#   global zprofile
#   .zprofile
#
# If interactive shell
#   global zshrc
#   .zshrc
#
# If login shell
#   global zlogin
#   .zlogin

# use .localrc for settings specific to one system
[[ -f ~/.localenv ]] && source  ~/.localenv
