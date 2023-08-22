#### 1. To install the latest Metrics Server release from the components.yaml manifest, run the following command :
```sh
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```
#### if you have a failed like this :""
"Failed to scrape node" err="Get \"https://xxx.xxx.xxx.xxx:10250/metrics/resource\": x509: cannot validate certificate for xxx.xxx.xxx.yyy because it doesn't contain any IP SANs" node="MyWorker-node""

##### My solution :
##### 1. edit the deployment object
```sh
kubectl edit deployments.apps/metrics-server
``` 
##### 2. add this line to de spec.template.spec.containers.args :
```sh
--kubelet-insecure-tls
```
##### 3. delete all pods related to metrics-servers
```sh
kubectl delete pod metrics-server-xxxxxxxxx-yyyyyy
```
##### 4. wait a moment and test 
```sh
kubectl top nodes --sort-by=memory
kubectl top pods --sort-by=memory
```

