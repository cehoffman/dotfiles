. ~/.dotfiles/zsh/completion
. ~/.dotfiles/zsh/corrections
. ~/.dotfiles/zsh/bindings
. ~/.dotfiles/zsh/prompt

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
