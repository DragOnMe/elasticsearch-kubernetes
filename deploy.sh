#!/usr/bin/env bash

if [ -z "${KUBECONFIG}" ]; then
    export KUBECONFIG=~/.kube/config
fi

# CAUTION - setting NAMESPACE will deploy most components to the given namespace
# however some are hardcoded to 'monitoring'. Only use if you have reviewed all manifests.

if [ -z "${NAMESPACE}" ]; then
    NAMESPACE=ns-elastic-only
fi

kubectl create namespace "$NAMESPACE"

kctl() {
    kubectl --namespace "$NAMESPACE" "$@"
}
# alias kctl='kubectl --namespace ns-elastic-only'

# Deploy Elasticsearch service
kctl apply -f 00-es-govern-for-sts-svc.yaml
kctl apply -f 01-es-configmap.yaml

# Check Rollout status of the statefulset
kctl apply -f 02-es-node-sts.yaml
until kctl rollout status statefulset esnode; do sleep 1; done

kctl apply -f 03-es-load-balancer-svc.yaml
echo 'done'
echo
