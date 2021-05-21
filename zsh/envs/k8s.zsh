if (( $+commands[kubectl] )); then
  alias k="kubectl"

  # Create an updated version of kubectl completion
  if [[ -o interactive && ! -f ~/.dotfiles/zsh/functions/_kubectl ]]; then
    kubectl completion zsh > ~/.dotfiles/zsh/functions/_kubectl
  fi

  # Build kubeconfig from a file to hold current context (~/.kube/config) and
  # individual config files that are most likely for individual clusters
  typeset -gxUT KUBECONFIG kubeconfig=(~/.kube/config $HOME:q/.kube/configs/*(.))
fi
