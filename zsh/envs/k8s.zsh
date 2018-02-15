if (( $+commands[kubectl] )); then
  alias kubectl="env -u DYLD_INSERT_LIBRARIES command kubectl"
  alias k="kubectl"
  # source <(kubectl completion zsh)

  # k() {
  #   k "$@" ${KUBE_NAMESPACE+-n $KUBE_NAMESPACE}
  # }
  
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

  kexec() {                                                                                                                                                                                                    12:50 on Thu Oct 19
    k exec -n "${1}" -it "$(k get po -n "${1}" -l "${2}" -o jsonpath="{.items[0].metadata.name}")" "${3-bash}" "${@:3}"
  }
fi
