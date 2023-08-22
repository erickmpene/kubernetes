# We will use Kube-Prometheus-stack

/!\ `I guess you already have helm installed on your server` 

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
chmod 600 ~/.kube/config # only if you have a warning like "Kubernetes configuration file is group-readable. This is insecure ..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install myprometheus prometheus-community/kube-prometheus-stack
```
##### 4. Deploy ingress for grafana dashboard
```sh
kubectl apply -f ingress.yaml
```
Default :
- user: admin
- password : prom-operator 
  # this value can change. Visit this github for more information [GIHUB-values.yaml](https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml)

