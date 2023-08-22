#### We will use Prometheus and Grafana

/!\ ````I guess you already have helm installed on your server```` 

##### 1. Update Helm repo 
```sh
helm repo update
```
##### 2. Create a new namespace, example "monitoring" in your cluster
```sh
kubectl create namespace monitoring
kubectl config set-context --current --namespace=monitoring
``` 
##### 3. Install prometheus via helm
```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

