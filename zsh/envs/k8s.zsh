if (( $+commands[kubectl] )); then
  alias kubectl="env -u DYLD_INSERT_LIBRARIES kubectl"
  alias k="kubectl"

  # Create an updated version of kubectl completion
  if [ ! -f ~/.dotfiles/zsh/functions/_kubectl ]; then
    kubectl completion zsh > ~/.dotfiles/zsh/functions/_kubectl
  fi

  # Build kubeconfig from a file to hold current context (~/.kube/config) and
  # individual config files that are most likely for individual clusters
  typeset -gxUT KUBECONFIG kubeconfig=(~/.kube/config "${HOME}"/.kube/configs/*(.))

  ksanitize() {
    jq 'del(.spec.clusterIP,
        .metadata.uid,
        .metadata.selfLink,
        .metadata.resourceVersion,
        .metadata.creationTimestamp,
        .metadata.generation,
        .status,
        .spec.template.spec.securityContext,
        .spec.template.spec.dnsPolicy,
        .spec.template.spec.terminationGracePeriodSeconds,
        .spec.template.spec.restartPolicy)'
  }

  kexec() {
    k exec -it "$(k get po -l "${1}" -o jsonpath="{.items[0].metadata.name}")" "${2-bash}" "${@:2}"
  }
fi
