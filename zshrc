source ~/.dotfiles/zsh/completion
source ~/.dotfiles/zsh/corrections
source ~/.dotfiles/zsh/bindings
source ~/.dotfiles/zsh/prompt

# use .localrc for settings specific to one system
if [[ -f ~/.localrc ]]; then source  ~/.localrc; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/cehoffman/.homebrew/bin/mc mc
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/cehoffman/.homebrew/bin/kustomize kustomize
