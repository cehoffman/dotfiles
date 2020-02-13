source ~/.dotfiles/zsh/completion
source ~/.dotfiles/zsh/corrections
source ~/.dotfiles/zsh/bindings
source ~/.dotfiles/zsh/prompt

# use .localrc for settings specific to one system
if [[ -f ~/.localrc ]]; then source  ~/.localrc; fi

# These lines are added by respective commands completion install hook
complete -o nospace -C /Users/cehoffman/.homebrew/bin/mc mc
complete -o nospace -C /Users/cehoffman/.homebrew/bin/kustomize kustomize
