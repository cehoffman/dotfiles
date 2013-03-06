. ~/.zsh/completion
. ~/.zsh/corrections
. ~/.zsh/bindings
. ~/.zsh/prompt

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
