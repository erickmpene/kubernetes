### Logging with EFK (ElasticSearch + Fluentd + Kibana)

This code is based on the great [digital ocean tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-elasticsearch-fluentd-and-kibana-efk-logging-stack-on-kubernetes). 

##### 1. Namespace
```sh
kubectl create -f logging.yaml
kubectl config set-context --current --namespace=logging
```
##### 2. ElasticSearch
```sh
kubectl create -f elasticsearch_svc.yaml
kubectl create -f elasticsearch_statefulset.yaml
```
##### 3. Verify elasticsearch
```sh
kubectl rollout status sts/es-cluster --namespace=logging
```
##### 4. Kibana
```sh
kubectl create -f kibana.yaml
```
##### 5. Verify Kibana
```sh
kubectl rollout status deployment/kibana --namespace=logging
```
##### 6. Fluentd
```sh
kubectl create -f fluentd.yaml
kubectl get ds --namespace=logging
```
