. ~/.zsh/config
. ~/.zsh/aliases

if [[ -o interactive  ]]; then
  . ~/.zsh/completion
  . ~/.zsh/corrections
  . ~/.zsh/bindings
  . ~/.zsh/prompt
fi

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

