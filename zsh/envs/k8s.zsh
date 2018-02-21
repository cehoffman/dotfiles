if (( $+commands[kubectl] )); then
  alias kubectl="env -u DYLD_INSERT_LIBRARIES kubectl"
  alias k="kubectl"
  # source <(kubectl completion zsh)

  pod-name() {
    kubectl get po "${@}" -o json | jq -r '.items | map(select(.status.phase == "Running")) | first.metadata.name'
  }
  
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

  redeploy() {
    kubectl patch -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"$(date +%s)\"}}}}}" "$@"
  }

  kexec() {
    k exec -n "${1}" -it "$(k get po -n "${1}" -l "${2}" -o jsonpath="{.items[0].metadata.name}")" "${3-bash}" "${@:3}"
  }
fi
