#!/usr/bin/env bash

if [ -z "${KUBECONFIG}" ]; then
    export KUBECONFIG=~/.kube/config
fi

# CAUTION - setting NAMESPACE will deploy most components to the given namespace
# however some are hardcoded to 'monitoring'. Only use if you have reviewed all manifests.

if [ -z "${NAMESPACE}" ]; then
    NAMESPACE=ns-elastic-only
fi

kctl() {
    kubectl --namespace "$NAMESPACE" "$@"
}
# alias kctl='kubectl --namespace ns-elastic-only'

# Delete Elasticsearch service
kctl delete -f 03-es-load-balancer-svc.yaml
kctl delete -f 02-es-node-sts.yaml
kctl delete -f 01-es-configmap.yaml
kctl delete -f 00-es-govern-for-sts-svc.yaml

# Delete pvc
for i in $(seq 0 1); do kctl delete pvc es-data-esnode-$i; done

kubectl delete namespace ns-elastic-only

echo 'done'
echo
