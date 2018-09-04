# A brief implementation of Elasticsearch Cluster in Kubernetes

 - Deploying an elasticsearch cluster: stateful sets, configmaps and services
 - with persistent volumes for each pod storage

## Prerequisites

 - A working kubernetes cluster with persistent storage like glusterfs, EBS, etc.
 - Kubernetes 1.11(1.10 will also be ok) can be either in local machines or public cloud like EC2, GCP or Azure service

## Comments

 - In the Elasticsearch 6.2.4 image, x-pack is included(as of 6.3, it's become free!) 
 - For the external access(via curl or web browser), I used NodePort service type not the LoadBalancer
 - Just run 'deploy.sh' to create or 'teardown.sh' to destroy
 - After successful deployment, use 'curl -s http://10.255.10.171:32000/_cat/nodes?v' or visit the URL by web browser

## References

 * [Installing Elasticsearch in Kubernetes](https://scriptedmotion.com/es-in-k8s/)
